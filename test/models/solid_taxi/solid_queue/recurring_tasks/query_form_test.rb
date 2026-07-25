require "test_helper"

class SolidTaxi::SolidQueue::RecurringTasks::QueryFormTest < ActiveSupport::TestCase
  test "form_fields" do
    params = ActionController::Parameters.new(
      query: {
        key: "recurring_task-key",
        schedule: "recurring_task-schedule",
        command: "recurring_task-command",
        class_name: "recurring_task-class_name",
        arguments: "recurring_task-arguments",
        queue_name: "recurring_task-queue_name",
        priority_from: "23800",
        priority_to: "23900",
        description: "recurring_task-description"
      }
    )

    SolidTaxi::SolidQueue::RecurringTasks::Page.new(params).query_form.tap do |query_form|
      assert_equal "recurring_task-key", query_form.key
      assert_equal "recurring_task-schedule", query_form.schedule
      assert_equal "recurring_task-command", query_form.command
      assert_equal "recurring_task-class_name", query_form.class_name
      assert_equal "recurring_task-arguments", query_form.arguments
      assert_equal "recurring_task-queue_name", query_form.queue_name
      assert_equal "23800", query_form.priority_from
      assert_equal "23900", query_form.priority_to
      assert_equal "recurring_task-description", query_form.description
    end
  end
end
