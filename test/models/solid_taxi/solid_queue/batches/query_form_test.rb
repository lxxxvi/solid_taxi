require "test_helper"

class SolidTaxi::SolidQueue::Batches::QueryFormTest < ActiveSupport::TestCase
  test "form_fields" do
    params = ActionController::Parameters.new(
      query: {
        id: "batch-id",
        active_job_batch_id: "batch-active_job_batch_id",
        description: "batch-description",
        on_finish: "batch-on_finish",
        on_success: "bash-on_success",
        on_failure: "batch-on_failure",
        metadata: "batch-metadata",
        total_jobs_from: "2000",
        total_jobs_to: "2001",
        completed_jobs_from: "3000",
        completed_jobs_to: "3001",
        failed_jobs_from: "4000",
        failed_jobs_to: "4001",
        enqueued_at_from: "2000-05-14T12:00",
        enqueued_at_to: "2000-05-14T13:00",
        finished_at_from: "2000-05-14T14:00",
        finished_at_to: "2000-05-14T15:00",
        failed_at_from: "2000-05-14T16:00",
        failed_at_to: "2000-05-14T17:00"
      }
    )

    SolidTaxi::SolidQueue::Batches::Page.new(params).query_form.tap do |query_form|
      assert_equal "batch-id", query_form.id
      assert_equal "batch-active_job_batch_id", query_form.active_job_batch_id
      assert_equal "batch-description", query_form.description
      assert_equal "batch-on_finish", query_form.on_finish
      assert_equal "bash-on_success", query_form.on_success
      assert_equal "batch-on_failure", query_form.on_failure
      assert_equal "batch-metadata", query_form.metadata
      assert_equal "2000", query_form.total_jobs_from
      assert_equal "2001", query_form.total_jobs_to
      assert_equal "3000", query_form.completed_jobs_from
      assert_equal "3001", query_form.completed_jobs_to
      assert_equal "4000", query_form.failed_jobs_from
      assert_equal "4001", query_form.failed_jobs_to
      assert_equal "2000-05-14T12:00", query_form.enqueued_at_from
      assert_equal "2000-05-14T13:00", query_form.enqueued_at_to
      assert_equal "2000-05-14T14:00", query_form.finished_at_from
      assert_equal "2000-05-14T15:00", query_form.finished_at_to
      assert_equal "2000-05-14T16:00", query_form.failed_at_from
      assert_equal "2000-05-14T17:00", query_form.failed_at_to
    end
  end
end
