require "test_helper"

class SolidTaxi::SolidQueue::Pauses::QueryTest < ActiveSupport::TestCase
  test "#scope, queue_name, like" do
    with_query_params(queue_name: "default") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(queue_name: "aused") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, solid_queue_pauses(:paused_queue)
    end
  end

  private

  def with_params(**args)
    params = ActionController::Parameters.new(args)
    query = SolidTaxi::SolidQueue::Pauses::Page.new(params).query

    yield query
  end

  def with_query_params(**args, &)
    with_params(query: args, &)
  end
end
