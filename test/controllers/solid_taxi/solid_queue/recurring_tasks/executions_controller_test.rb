require "test_helper"

class SolidTaxi::SolidQueue::RecurringTasks::ExecutionsControllerTest < ActionDispatch::IntegrationTest
  test "GET index, unauthorized" do
    recurring_task = solid_queue_recurring_tasks(:random)
    get solid_queue_recurring_task_executions_path(recurring_task)

    assert_response :unauthorized
  end

  test "GET index, redirects if Solid Queue is not available" do
    recurring_task = solid_queue_recurring_tasks(:random)

    authenticated_in_dummy_app do
      SolidTaxi::SolidQueue.stub(:version, nil) do
        get solid_queue_recurring_task_executions_path(recurring_task)
      end

      assert_response :redirect

      follow_redirect!

      assert_response :success

      assert_dom("p", "Welcome to Solid Taxi!")
    end
  end

  test "GET index, authorized" do
    recurring_task = solid_queue_recurring_tasks(:random)

    authenticated_in_dummy_app do
      get solid_queue_recurring_task_executions_path(recurring_task)

      assert_response :success
      assert_dom("h1", "Solid Taxi navigation")
      assert_dom("h2", "Solid Queue")
      assert_dom("h3", "Solid Queue Navigation")
      assert_dom("h4", "Recurring Task")
      assert_dom("h5", "Solid Queue Recurring Task Navigation")
      assert_dom("h6", "Recurring Executions")
    end
  end
end
