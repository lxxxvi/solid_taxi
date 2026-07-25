require "test_helper"

class SolidTaxi::QueryTest < ActiveSupport::TestCase
  test "instance_methods, no params" do
    SolidQueue::Pause.create!(
      [
        { queue_name: "queue_9" },
        { queue_name: "queue_8" },
        { queue_name: "queue_7" },
        { queue_name: "queue_6" },
        { queue_name: "queue_5" },
        { queue_name: "queue_4" },
        { queue_name: "queue_3" },
        { queue_name: "queue_2" },
        { queue_name: "queue_1" }
      ]
    )

    pauses_page_with_query do |query|
      assert_equal 10, query.scope.count("1")
      assert_equal 10, query.rows.count("1")
      assert_equal 10, query.total_rows
      assert_equal query.rows.first.queue_name, "paused_queue"
      assert_equal query.rows.last.queue_name, "queue_9"
    end

    pauses_page_with_query(pagination: { limit: 4 }) do |query|
      assert_equal 10, query.scope.count
      assert_equal 4, query.rows.count
      assert_equal 10, query.total_rows
      assert_equal query.rows.first.queue_name, "paused_queue"
      assert_equal query.rows.last.queue_name, "queue_3"
    end

    pauses_page_with_query(pagination: { limit: 4, page: 2 }) do |query|
      assert_equal 10, query.scope.count
      assert_equal 4, query.rows.count
      assert_equal 10, query.total_rows
      assert_equal query.rows.first.queue_name, "queue_4"
      assert_equal query.rows.last.queue_name, "queue_7"
    end

    pauses_page_with_query(pagination: { limit: 4, page: 3 }) do |query|
      assert_equal 10, query.scope.count
      assert_equal 2, query.rows.count
      assert_equal 10, query.total_rows
      assert_equal query.rows.first.queue_name, "queue_8"
      assert_equal query.rows.last.queue_name, "queue_9"
    end

    pauses_page_with_query(pagination: { limit: 4, page: 4 }) do |query|
      assert_equal 10, query.scope.count
      assert_equal 0, query.rows.count
      assert_equal 10, query.total_rows
    end
  end

  test "multiple query params" do
    query = {
      created_at_from: "2026-08-03T00:00",
      created_at_to: "2026-08-04T00:00",
      channel_hash: "4555180985467693480"
    }

    messages_page_with_query(query:) do |query|
      assert_equal 1, query.scope.count
      assert_equal 1, query.total_rows
      assert_equal 1, query.rows.count

      assert_equal query.rows.first, solid_cable_messages(:channel_4_on_2026_08_03_at_02_53_20)
    end
  end

  test "multiple query params, with pagination and ordering" do
    # page 1
    pagination = {
      limit: 2,
      page: 1
    }

    query = {
      created_at_from: "2026-08-03T00:00",
      created_at_to: "2026-08-04T00:00"
    }

    messages_page_with_query(pagination:, query:) do |query|
      assert_equal 6, query.scope.count
      assert_equal 6, query.total_rows
      assert_equal 2, query.rows.count

      assert_equal query.rows.first, solid_cable_messages(:channel_7_on_2026_08_03_at_23_25_00)
      assert_equal query.rows.last, solid_cable_messages(:channel_2_on_2026_08_03_at_21_40_00)
    end

    # page 2
    pagination = {
      limit: 2,
      page: 2
    }

    messages_page_with_query(pagination:, query:) do |query|
      assert_equal 6, query.scope.count
      assert_equal 6, query.total_rows
      assert_equal 2, query.rows.count

      assert_equal query.rows.first, solid_cable_messages(:channel_6_on_2026_08_03_at_21_33_20)
      assert_equal query.rows.last, solid_cable_messages(:channel_6_on_2026_08_03_at_19_18_20)
    end

    # page 3
    pagination = {
      limit: 2,
      page: 3
    }

    messages_page_with_query(pagination:, query:) do |query|
      assert_equal 6, query.scope.count
      assert_equal 6, query.total_rows
      assert_equal 2, query.rows.count

      assert_equal query.rows.first, solid_cable_messages(:channel_3_on_2026_08_03_at_16_00_00)
      assert_equal query.rows.last, solid_cable_messages(:channel_4_on_2026_08_03_at_02_53_20)
    end
  end

  private

  def pauses_page_with_query(**args, &)
    params = ActionController::Parameters.new(args)

    yield SolidTaxi::SolidQueue::Pauses::Page.new(params).query
  end

  def messages_page_with_query(**args, &)
    params = ActionController::Parameters.new(args)

    yield SolidTaxi::SolidCable::Messages::Page.new(params).query
  end
end
