require "test_helper"

class SolidTaxi::SolidQueue::RecurringTasks::QueryTest < ActiveSupport::TestCase
  test "#scope, key, like" do
    recurring_task = solid_queue_recurring_tasks(:semaphory)

    with_query_params(key: "semaphory") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, recurring_task
    end  end

  test "#scope, schedule, like" do
    recurring_task = solid_queue_recurring_tasks(:clear_solid_queue_finished_jobs)

    with_query_params(schedule: "hour at minute") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, recurring_task
    end
  end

  test "#scope, command, like" do
    recurring_task = solid_queue_recurring_tasks(:random)

    with_query_params(command: "SecureRandom") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, recurring_task
    end
  end

  test "#scope, class_name, like" do
    recurring_task = solid_queue_recurring_tasks(:sleepy)

    with_query_params(class_name: "SleepyJob") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, recurring_task
    end
  end

  test "#scope, arguments, like" do
    recurring_task = solid_queue_recurring_tasks(:sleepy)

    with_query_params(arguments: "1") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, recurring_task
    end
  end

  test "#scope, queue_name, like" do
    recurring_task = solid_queue_recurring_tasks(:random)

    recurring_task.update_column(:queue_name, "random_queue")

    with_query_params(queue_name: "dom_que") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, recurring_task
    end
  end

  test "#scope, priority, number range" do
    recurring_task = solid_queue_recurring_tasks(:random)

    recurring_task.update_column(:priority, "-1")

    with_query_params(priority_to: "-2") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(priority_to: "-1") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, recurring_task
    end

    with_query_params(priority_from: "0") do |query|
      assert_equal 3, query.scope.count
    end

    with_query_params(priority_from: "1") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, description, like" do
    recurring_task = solid_queue_recurring_tasks(:clear_solid_queue_finished_jobs)

    with_query_params(description: "state finished") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, recurring_task
    end
  end

  private

  def with_params(**args)
    params = ActionController::Parameters.new(args)
    query = SolidTaxi::SolidQueue::RecurringTasks::Page.new(params).query

    yield query
  end

  def with_query_params(**args, &)
    with_params(query: args, &)
  end
end
