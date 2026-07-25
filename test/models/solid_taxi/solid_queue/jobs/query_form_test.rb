require "test_helper"

class SolidTaxi::SolidQueue::Jobs::QueryFormTest < ActiveSupport::TestCase
  test "form_fields" do
    params = ActionController::Parameters.new(
      query: {
        queue_name: "job-queue_name",
        class_name: "job-class_name",
        arguments: "job-arguments",
        priority_from: "6300",
        priority_to: "6400",
        active_job_id: "job-active_job_id",
        scheduled_at_from: "2000-02-18T12:00",
        scheduled_at_to: "2000-02-18T13:00",
        finished_at_from: "2000-02-18T14:00",
        finished_at_to: "2000-02-18T15:00",
        concurrency_key: "job-concurrency_key",
        batch_id: "600002000",
        custom__status: "job-claimed"
      }
    )

    SolidTaxi::SolidQueue::Jobs::Page.new(params).query_form.tap do |query_form|
      assert_equal "job-queue_name", query_form.queue_name
      assert_equal "job-class_name", query_form.class_name
      assert_equal "job-arguments", query_form.arguments
      assert_equal "6300", query_form.priority_from
      assert_equal "6400", query_form.priority_to
      assert_equal "job-active_job_id", query_form.active_job_id
      assert_equal "2000-02-18T12:00", query_form.scheduled_at_from
      assert_equal "2000-02-18T13:00", query_form.scheduled_at_to
      assert_equal "2000-02-18T14:00", query_form.finished_at_from
      assert_equal "2000-02-18T15:00", query_form.finished_at_to
      assert_equal "job-concurrency_key", query_form.concurrency_key
      assert_equal "600002000", query_form.batch_id
      assert_equal "job-claimed", query_form.custom__status
    end
  end
end
