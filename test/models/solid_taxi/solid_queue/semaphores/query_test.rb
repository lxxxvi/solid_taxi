require "test_helper"

class SolidTaxi::SolidQueue::Semaphores::QueryTest < ActiveSupport::TestCase
  test "#scope, key, like" do
    semaphore = solid_queue_semaphores(:semaphory_job_semaphore)

    with_query_params(key: "semaphory_job") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, semaphore
    end

    with_query_params(key: "noop") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, value, number range" do
    semaphore = solid_queue_semaphores(:semaphory_job_semaphore)

    with_query_params(value_to: "-1") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(value_to: "0") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, semaphore
    end

    with_query_params(value_from: "0") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, semaphore
    end

    with_query_params(value_from: "1") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, expires_at, time range" do
    semaphore = solid_queue_semaphores(:semaphory_job_semaphore)

    with_query_params(expires_at_to: "2026-08-01T00:02") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(expires_at_to: "2026-08-01T00:03") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, semaphore
    end

    with_query_params(expires_at_from: "2026-08-01T00:02") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, semaphore
    end

    with_query_params(expires_at_from: "2026-08-01T00:03") do |query|
      assert_equal 0, query.scope.count
    end
  end

  private

  def with_params(**args)
    params = ActionController::Parameters.new(args)
    query = SolidTaxi::SolidQueue::Semaphores::Page.new(params).query

    yield query
  end

  def with_query_params(**args, &)
    with_params(query: args, &)
  end
end
