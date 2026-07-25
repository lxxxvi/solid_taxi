require "test_helper"

class SolidTaxi::SolidQueue::Jobs::QueryTest < ActiveSupport::TestCase
  test "#scope, queue_name, like" do
    with_query_params(class_name: "recurring") do |query|
      assert_equal 5, query.scope.count("1")
      assert_includes query.scope, solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_42_00)
      assert_includes query.scope, solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_43_00)
      assert_includes query.scope, solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_44_00)
      assert_includes query.scope, solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_45_00)
      assert_includes query.scope, solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_46_00)
    end
  end

  test "#scope, class_name, like" do
    with_query_params(class_name: "Crash") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, solid_queue_jobs(:batch_failing_crash_job)
    end
  end

  test "#scope, arguments, like" do
    with_query_params(arguments: "411216fcf467") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_42_00)
    end
  end

  test "#scope, priority, number range" do
    job_a = solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_42_00)
    job_a.update_column(:priority, -1)

    job_b = solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_43_00)
    job_b.update_column(:priority, 1)

    with_query_params(priority_to: "-2") do |query|
      assert_equal 0, query.scope.count("1")
    end

    with_query_params(priority_to: "-1") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, job_a
    end

    with_query_params(priority_from: "1") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, job_b
    end

    with_query_params(priority_from: "2") do |query|
      assert_equal 0, query.scope.count("1")
    end
  end

  test "#scope, active_job_id, like" do
    with_query_params(active_job_id: "9071") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, solid_queue_jobs(:recurring_solid_queue_recurring_job_on_2026_08_01_at_00_42_00)
    end
  end

  test "#scope, scheduled_at, time range" do
    with_query_params(scheduled_at_to: "2026-08-01T00:33") do |query|
      assert_equal 0, query.scope.count("1")
    end

    with_query_params(scheduled_at_to: "2026-08-01T00:34") do |query|
      assert_equal 7, query.scope.count("1")
    end

    with_query_params(scheduled_at_from: "2026-08-01T00:57") do |query|
      assert_equal 2, query.scope.count("1")
    end

    with_query_params(scheduled_at_from: "2026-08-01T00:58") do |query|
      assert_equal 0, query.scope.count("1")
    end
  end

  test "#scope, finished_at, time range" do
    with_query_params(finished_at_to: "2026-08-01T00:33") do |query|
      assert_equal 0, query.scope.count("1")
    end

    with_query_params(finished_at_to: "2026-08-01T00:34") do |query|
      assert_equal 7, query.scope.count("1")
    end

    with_query_params(finished_at_from: "2026-08-01T00:57") do |query|
      assert_equal 3, query.scope.count("1")
    end

    with_query_params(finished_at_from: "2026-08-01T00:58") do |query|
      assert_equal 0, query.scope.count("1")
    end
  end

  test "#scope, concurrency_key, like" do
    with_query_params(concurrency_key: "semaphory_job") do |query|
      assert_equal 3, query.scope.count("1")
      assert_includes query.scope, solid_queue_jobs(:recurring_semaphory_job_on_on_2026_08_01_at_00_51_00)
      assert_includes query.scope, solid_queue_jobs(:recurring_semaphory_job_on_on_2026_08_01_at_00_52_00)
      assert_includes query.scope, solid_queue_jobs(:recurring_semaphory_job_on_on_2026_08_01_at_00_53_00)
    end
  end

  test "#scope, batch_id, exact" do
    successful_batch = solid_queue_batches(:successful_batch)

    with_query_params(batch_id: successful_batch.id) do |query|
      assert_equal 5, query.scope.count("1")
      assert_includes query.scope, solid_queue_jobs(:batch_successful_batch_sleepy_job_0)
      assert_includes query.scope, solid_queue_jobs(:batch_successful_batch_sleepy_job_4)
    end
  end

  test "#scope, custom__status, like" do
    failing_job = solid_queue_jobs(:batch_failing_crash_job)

    with_query_params(custom__status: "failed") do |query|
      assert_equal 1, query.scope.count("1")
      assert_includes query.scope, failing_job
    end
  end

  private

  def with_params(**args)
    params = ActionController::Parameters.new(args)
    query = SolidTaxi::SolidQueue::Jobs::Page.new(params).query

    yield query
  end

  def with_query_params(**args, &)
    with_params(query: args, &)
  end
end
