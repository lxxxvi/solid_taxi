require "test_helper"

class SolidTaxi::SolidQueue::RecurringTasks::Executions::PageTest < ActiveSupport::TestCase
  test ".new" do
    recurring_task = solid_queue_recurring_tasks(:random)

    params = ActionController::Parameters.new(recurring_task_id: recurring_task.id)

    SolidTaxi::SolidQueue::RecurringTasks::Executions::Page.new(params).tap do |page|
      assert_equal SolidTaxi::SolidQueue::RecurringTasks::Executions::QueryForm, page.query_form.class
      assert_equal SolidTaxi::Pagination, page.pagination.class
      assert_equal SolidTaxi::SolidQueue::RecurringTasks::Executions::Query, page.query.class

      assert_equal recurring_task, page.recurring_task
    end
  end
end
