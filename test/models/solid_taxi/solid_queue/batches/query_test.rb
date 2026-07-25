require "test_helper"

class SolidTaxi::SolidQueue::Batches::QueryTest < ActiveSupport::TestCase
  test "#scope, all" do
    with_params do |query|
      assert_equal 3, query.scope.count
    end
  end

  test "#scope, id, exact" do
    batch = solid_queue_batches(:successful_batch)

    with_query_params(id: batch.id) do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, batch
    end

    with_query_params(id: 0) do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, active_job_batch_id, like" do
    batch = solid_queue_batches(:successful_batch)

    with_query_params(active_job_batch_id: "ca4759bd") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, batch
    end
  end

  test "#scope, description, like" do
    batch = solid_queue_batches(:successful_batch)

    with_query_params(description: "Successful") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, batch
    end

    with_query_params(description: "Batch") do |query|
      assert_equal 2, query.scope.count
    end
  end

  test "#scope, on_finish, like" do
    batch = solid_queue_batches(:successful_batch)

    with_query_params(on_finish: "1712860e") do |query|
      assert_equal 1, query.scope.count
      batch = solid_queue_batches(:successful_batch)
    end

    with_query_params(on_finish: "BatchFinishJob") do |query|
      assert_equal 3, query.scope.count
    end
  end

  test "#scope, on_success, like" do
    batch = solid_queue_batches(:successful_batch)

    with_query_params(on_success: "20be9f42") do |query|
      assert_equal 1, query.scope.count
      batch = solid_queue_batches(:successful_batch)
    end

    with_query_params(on_success: "BatchSuccessJob") do |query|
      assert_equal 2, query.scope.count
    end
  end

  test "#scope, on_failure, like" do
    batch = solid_queue_batches(:successful_batch)

    with_query_params(on_failure: "ac15fa5f") do |query|
      assert_equal 1, query.scope.count
      batch = solid_queue_batches(:successful_batch)
    end

    with_query_params(on_failure: "BatchFailureJob") do |query|
      assert_equal 2, query.scope.count
    end
  end

  test "#scope, metadata, like" do
    batch = solid_queue_batches(:successful_batch)

    with_query_params(metadata: "user_id") do |query|
      assert_equal 1, query.scope.count
      batch = solid_queue_batches(:successful_batch)
    end
  end

  test "#scope, total_jobs, number range" do
    successful_batch, failing_batch, unfinished_batch = solid_queue_batches(:successful_batch, :failing_batch, :unfinished_batch)

    with_query_params(total_jobs_to: "1") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(total_jobs_to: "2") do |query|
      assert_equal 2, query.scope.count
      assert_includes query.scope, failing_batch
      assert_includes query.scope, unfinished_batch
    end

    with_query_params(total_jobs_from: "3") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, successful_batch
    end

    with_query_params(total_jobs_from: "6") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, completed_jobs, number range" do
    successful_batch, failing_batch, unfinished_batch = solid_queue_batches(:successful_batch, :failing_batch, :unfinished_batch)

    with_query_params(completed_jobs_to: "0") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(completed_jobs_to: "1") do |query|
      assert_equal 2, query.scope.count
      assert_includes query.scope, failing_batch
      assert_includes query.scope, unfinished_batch
    end

    with_query_params(completed_jobs_from: "5") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, successful_batch
    end

    with_query_params(completed_jobs_from: "6") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, failed_jobs, number range" do
    successful_batch, failing_batch, unfinished_batch = solid_queue_batches(:successful_batch, :failing_batch, :unfinished_batch)

    failing_batch.update_column(:failed_jobs, 1)

    with_query_params(failed_jobs_to: "-1") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(failed_jobs_to: "0") do |query|
      assert_equal 2, query.scope.count
      assert_includes query.scope, successful_batch
      assert_includes query.scope, unfinished_batch
    end

    with_query_params(failed_jobs_from: "1") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, failing_batch
    end

    with_query_params(failed_jobs_from: "2") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, enqueued_at, time range" do
    successful_batch, failing_batch = solid_queue_batches(:successful_batch, :failing_batch)

    with_query_params(enqueued_at_to: "2026-08-01T00:33") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(enqueued_at_to: "2026-08-01T00:34") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, successful_batch
    end

    with_query_params(enqueued_at_from: "2026-08-01T00:53") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, failing_batch
    end

    with_query_params(enqueued_at_from: "2026-08-01T00:54") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, finished_at, time range" do
    successful_batch, failing_batch = solid_queue_batches(:successful_batch, :failing_batch)

    with_query_params(finished_at_to: "2026-08-01T00:33") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(finished_at_to: "2026-08-01T00:34") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, successful_batch
    end

    with_query_params(finished_at_from: "2026-08-01T00:57") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, failing_batch
    end

    with_query_params(finished_at_from: "2026-08-01T00:58") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, failed_at, time range" do
    successful_batch, failing_batch = solid_queue_batches(:successful_batch, :failing_batch)

    successful_batch.update_column(:failed_at, "2026-08-01T00:12:01")
    failing_batch.update_column(:failed_at, "2026-08-01T00:15:59")

    with_query_params(failed_at_to: "2026-08-01T00:12") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(failed_at_to: "2026-08-01T00:13") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, successful_batch
    end

    with_query_params(failed_at_from: "2026-08-01T00:15") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, failing_batch
    end

    with_query_params(failed_at_from: "2026-08-01T00:16") do |query|
      assert_equal 0, query.scope.count
    end
  end

  private

  def with_params(**args)
    params = ActionController::Parameters.new(args)
    query = SolidTaxi::SolidQueue::Batches::Page.new(params).query

    yield query
  end

  def with_query_params(**args, &)
    with_params(query: args, &)
  end
end
