require "test_helper"

class SolidTaxi::SolidQueue::RecurringTasks::Executions::QueryTest < ActiveSupport::TestCase
  test "#scope, id, exact" do
    recurring_task = solid_queue_recurring_tasks(:random)
    recurring_execution = solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_42_00)

    with_query_params(recurring_task:, id: recurring_execution.id) do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, recurring_execution
    end

    with_query_params(recurring_task:, id: "0") do |query|
      assert_equal 0, query.scope.count("1")
    end
  end

  test "#scope, task_key, like" do
    recurring_task = solid_queue_recurring_tasks(:random)

    with_query_params(recurring_task:, task_key: "ando") do |query|
      assert_equal 5, query.scope.count("1")
    end

    solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_42_00).update_column(:task_key, "other")

    with_query_params(recurring_task:, task_key: "ando") do |query|
      assert_equal 4, query.scope.count("1")
    end
  end

  test "#scope, run_at, time range" do
    recurring_task = solid_queue_recurring_tasks(:random)

    with_query_params(recurring_task:, run_at_to: "2026-08-01T00:42") do |query|
      assert_equal 0, query.scope.count("1")
    end

    with_query_params(recurring_task:, run_at_to: "2026-08-01T00:43") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_42_00)
    end

    with_query_params(recurring_task:, run_at_from: "2026-08-01T00:46") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_46_00)
    end

    with_query_params(recurring_task:, run_at_from: "2026-08-01T00:47") do |query|
      assert_equal 0, query.scope.count("1")
    end
  end

  test "#scope, job__id, exact" do
    recurring_task = solid_queue_recurring_tasks(:random)
    job = solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_42_00)

    with_query_params(recurring_task:, job__id: job.id) do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_42_00)
    end

    with_query_params(recurring_task:, job__id: 0) do |query|
      assert_equal 0, query.scope.count("1")
    end
  end

  test "#scope, job__queue_name, like" do
    recurring_task = solid_queue_recurring_tasks(:random)

    with_query_params(recurring_task:, job__queue_name: "recurring") do |query|
      assert_equal 5, query.scope.count("1")
    end

    solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_42_00).update_column(:queue_name, "default")

    with_query_params(recurring_task:, job__queue_name: "recurring") do |query|
      assert_equal 4, query.scope.count("1")
    end
  end

  test "#scope, job__class_name, like" do
    recurring_task = solid_queue_recurring_tasks(:random)

    with_query_params(recurring_task:, job__class_name: "RecurringJob") do |query|
      assert_equal 5, query.scope.count("1")
    end

    solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_42_00).update_column(:class_name, "SleepyJob")

    with_query_params(recurring_task:, job__class_name: "RecurringJob") do |query|
      assert_equal 4, query.scope.count("1")
    end
  end

  test "#scope, job__arguments, like" do
    recurring_task = solid_queue_recurring_tasks(:random)
    recurring_execution = solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_42_00)

    with_query_params(recurring_task:, job__arguments: "468c") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, recurring_execution
    end
  end

  test "#scope, job__priority, number range" do
    recurring_task = solid_queue_recurring_tasks(:random)

    with_query_params(recurring_task:, job__priority_to: "-1") do |query|
      assert_equal 0, query.scope.count("1")
    end

    with_query_params(recurring_task:, job__priority_to: "0") do |query|
      assert_equal 5, query.scope.count("1")
    end

    with_query_params(recurring_task:, job__priority_from: "0") do |query|
      assert_equal 5, query.scope.count("1")
    end

    with_query_params(recurring_task:, job__priority_from: "1") do |query|
      assert_equal 0, query.scope.count("1")
    end
  end

  test "#scope, job__active_job_id, like" do
    recurring_task = solid_queue_recurring_tasks(:random)
    recurring_execution = solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_42_00)

    with_query_params(recurring_task:, job__active_job_id: "69ff590b") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, recurring_execution
    end
  end

  test "#scope, job__scheduled_at, time range" do
    recurring_task = solid_queue_recurring_tasks(:random)

    with_query_params(recurring_task:, job__scheduled_at_to: "2026-08-01T00:42") do |query|
      assert_equal 0, query.scope.count("1")
    end

    with_query_params(recurring_task:, job__scheduled_at_to: "2026-08-01T00:43") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_42_00)
    end

    with_query_params(recurring_task:, job__scheduled_at_from: "2026-08-01T00:46") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_46_00)
    end

    with_query_params(recurring_task:, job__scheduled_at_from: "2026-08-01T00:47") do |query|
      assert_equal 0, query.scope.count("1")
    end
  end

  test "#scope, job__finished_at, time range" do
    recurring_task = solid_queue_recurring_tasks(:random)

    with_query_params(recurring_task:, job__finished_at_to: "2026-08-01T00:42") do |query|
      assert_equal 0, query.scope.count("1")
    end

    with_query_params(recurring_task:, job__finished_at_to: "2026-08-01T00:43") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_42_00)
    end

    with_query_params(recurring_task:, job__finished_at_from: "2026-08-01T00:46") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_46_00)
    end

    with_query_params(recurring_task:, job__finished_at_from: "2026-08-01T00:47") do |query|
      assert_equal 0, query.scope.count("1")
    end
  end

  test "#scope, job__concurrency_key, like" do
    recurring_task = solid_queue_recurring_tasks(:random)

    with_query_params(recurring_task:, job__concurrency_key: "something") do |query|
      assert_equal 0, query.scope.count("1")
    end

    solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_42_00).update_column(:concurrency_key, "something")

    with_query_params(recurring_task:, job__concurrency_key: "something") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_42_00)
    end
  end

  test "#scope, job__custom__status, like" do
    recurring_task = solid_queue_recurring_tasks(:random)
    recurring_execution = solid_queue_recurring_executions(:recurring_random_on_2026_08_01_at_00_42_00)
    job = solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_42_00)

    with_query_params(recurring_task:, job__custom__status: "finished") do |query|
      assert_equal 5, query.scope.count("1")
    end

    job.update_column(:finished_at, nil)

    with_query_params(recurring_task:, job__custom__status: "unknown") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, recurring_execution
    end

    ::SolidQueue::FailedExecution.create!(job:, error: "some-errror")

    with_query_params(recurring_task:, job__custom__status: "failed") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, recurring_execution
    end

    # Creating a "blocked execution" takes the job's
    # "concurrency_key" as value for
    # INSERT INTO solid_queue_blocked_executions
    job.concurrency_key = "blocking-key"
    ::SolidQueue::BlockedExecution.create!(job:)

    with_query_params(recurring_task:, job__custom__status: "blocked") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, recurring_execution
    end

    process = solid_queue_processes(:worker)
    ::SolidQueue::ClaimedExecution.create!(job:, process:)

    with_query_params(recurring_task:, job__custom__status: "claimed") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, recurring_execution
    end

    ::SolidQueue::ReadyExecution.create!(job:)

    with_query_params(recurring_task:, job__custom__status: "ready") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, recurring_execution
    end

    ::SolidQueue::ScheduledExecution.create!(job:)

    with_query_params(recurring_task:, job__custom__status: "scheduled") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, recurring_execution
    end
  end

  def with_params(recurring_task:, **args)
    params = ActionController::Parameters.new(args.merge(recurring_task_id: recurring_task.id))
    query = SolidTaxi::SolidQueue::RecurringTasks::Executions::Page.new(params).query

    yield query
  end

  def with_query_params(recurring_task:, **args, &)
    with_params(recurring_task:, query: args, &)
  end
end
