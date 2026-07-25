require "test_helper"

class SolidTaxi::SolidQueue::Processes::QueryTest < ActiveSupport::TestCase
  test "#scope, kind, like" do
    with_query_params(kind: "or") do |query|
      assert_equal 2, query.scope.count
      assert_includes query.scope, solid_queue_processes(:supervisor)
      assert_includes query.scope, solid_queue_processes(:worker)
    end
  end

  test "#scope, last_heartbeat_at, time range" do
    with_query_params(last_heartbeat_at_to: "2026-08-01T00:54") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(last_heartbeat_at_to: "2026-08-01T00:55") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, solid_queue_processes(:supervisor)
    end

    with_query_params(last_heartbeat_at_from: "2026-08-01T00:57") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, solid_queue_processes(:worker)
    end

    with_query_params(last_heartbeat_at_from: "2026-08-01T00:58") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, supervisor_id, exact" do
    supervisor = solid_queue_processes(:supervisor)

    with_query_params(supervisor_id: supervisor.id) do |query|
      assert_equal 3, query.scope.count
      assert_includes query.scope, solid_queue_processes(:dispatcher)
      assert_includes query.scope, solid_queue_processes(:scheduler)
      assert_includes query.scope, solid_queue_processes(:worker)
    end
  end

  test "#scope, pid, exact" do
    with_query_params(pid: "1") do |query|
      assert_equal 0, query.scope.count
    end

    supervisor = solid_queue_processes(:supervisor)

    with_query_params(pid: "10") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, supervisor
    end
  end

  test "#scope, hostname, like" do
    with_query_params(hostname: "solid-queue-host") do |query|
      assert_equal 4, query.scope.count
    end

    supervisor = solid_queue_processes(:supervisor)
    supervisor.update_column(:hostname, "different-hostname")

    with_query_params(hostname: "different") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, supervisor
    end
  end

  test "#scope, metadata, like" do
    with_query_params(metadata: "polling_interval") do |query|
      assert_equal 2, query.scope.count
      assert_includes query.scope, solid_queue_processes(:dispatcher)
      assert_includes query.scope, solid_queue_processes(:worker)
    end
  end

  test "#scope, name, like" do
    with_query_params(name: "c3") do |query|
      assert_equal 2, query.scope.count
      assert_includes query.scope, solid_queue_processes(:dispatcher)
      assert_includes query.scope, solid_queue_processes(:worker)
    end
  end

  private

  def with_params(**args)
    params = ActionController::Parameters.new(args)
    query = SolidTaxi::SolidQueue::Processes::Page.new(params).query

    yield query
  end

  def with_query_params(**args, &)
    with_params(query: args, &)
  end
end
