require "test_helper"

class SolidTaxi::SolidQueue::Batches::Executions::QueryFormTest < ActiveSupport::TestCase
  test "form_fields" do
    params = ActionController::Parameters.new(
      query: {
        job__id: "job-id",
        job__queue_name: "job-queue_name",
        job__class_name: "job-class_name",
        job__arguments: "job-arguments",
        job__priority_from: "97700",
        job__priority_to: "97701",
        job__active_job_id: "job-active_job_id",
        job__scheduled_at_from: "2000-07-12T12:00",
        job__scheduled_at_to: "2000-07-12T13:00",
        job__finished_at_from: "2000-07-12T14:00",
        job__finished_at_to: "2000-07-12T15:00",
        job__concurrency_key: "job-concurrency_key",
        job__custom__status: "job-custom__status"
      }
    )

    SolidTaxi::SolidQueue::Batches::Executions::Page.new(params).query_form.tap do |query_form|
      assert_equal "job-id", query_form.job__id
      assert_equal "job-queue_name", query_form.job__queue_name
      assert_equal "job-class_name", query_form.job__class_name
      assert_equal "job-arguments", query_form.job__arguments
      assert_equal "97700", query_form.job__priority_from
      assert_equal "97701", query_form.job__priority_to
      assert_equal "job-active_job_id", query_form.job__active_job_id
      assert_equal "2000-07-12T12:00", query_form.job__scheduled_at_from
      assert_equal "2000-07-12T13:00", query_form.job__scheduled_at_to
      assert_equal "2000-07-12T14:00", query_form.job__finished_at_from
      assert_equal "2000-07-12T15:00", query_form.job__finished_at_to
      assert_equal "job-concurrency_key", query_form.job__concurrency_key
      assert_equal "job-custom__status", query_form.job__custom__status
    end
  end
end
