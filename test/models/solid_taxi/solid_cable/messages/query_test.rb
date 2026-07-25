require "test_helper"

class SolidTaxi::SolidCable::Messages::QueryTest < ActiveSupport::TestCase
  test "#scope, all" do
    with_params do |query|
      assert_equal 30, query.scope.count
    end
  end

  test "#scope, channel_hash, exact" do
    with_query_params(channel_hash: "-3313780325803705970") do |query|
      assert_equal 2, query.scope.count
      assert_includes query.scope, solid_cable_messages(:channel_1_on_2026_08_11_at_06_08_20)
      assert_includes query.scope, solid_cable_messages(:channel_1_on_2026_08_11_at_12_01_40)
    end

    with_query_params(channel_hash: "1") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, created_at, time range" do
    with_query_params(created_at_from: "2026-08-12T23:40") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, solid_cable_messages(:channel_4_on_2026_08_12_at_23_45_00)
    end

    with_query_params(created_at_to: "2026-08-01T15:22") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, solid_cable_messages(:channel_3_on_2026_08_01_at_15_21_40)
    end

    with_query_params(
      created_at_from: "2026-08-07T00:00",
      created_at_to: "2026-08-07T23:59"
    ) do |query|
      assert_equal 2, query.scope.count
      assert_includes query.scope, solid_cable_messages(:channel_2_on_2026_08_07_at_23_45_00)
      assert_includes query.scope, solid_cable_messages(:channel_3_on_2026_08_07_at_22_08_20)
    end
  end

  private

  def with_params(**args)
    params = ActionController::Parameters.new(args)
    query = SolidTaxi::SolidCable::Messages::Page.new(params).query

    yield query
  end

  def with_query_params(**args, &)
    with_params(query: args, &)
  end
end
