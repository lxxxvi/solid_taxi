require "test_helper"

class SolidTaxi::SolidQueue::RecurringTasksControllerTest < ActionDispatch::IntegrationTest
  test "GET index, unauthorized" do
    get solid_queue_recurring_tasks_path

    assert_response :unauthorized
  end

  test "GET index, redirects if Solid Queue is not available" do
    authenticated_in_dummy_app do
      SolidTaxi::SolidQueue.stub(:version, nil) do
        get solid_queue_recurring_tasks_path
      end

      assert_response :redirect

      follow_redirect!

      assert_response :success

      assert_dom("p", "Welcome to Solid Taxi!")
    end
  end

  test "GET index, authorized" do
    authenticated_in_dummy_app do
      get solid_queue_recurring_tasks_path

      assert_response :success
      assert_dom("h1", "Solid Taxi navigation")
      assert_dom("h2", "Solid Queue")
      assert_dom("h3", "Solid Queue Navigation")
      assert_dom("h4", "Recurring Tasks")
      refute_dom("h5")
    end
  end

  test "GET show, unauthorized" do
    recurring_task = solid_queue_recurring_tasks(:random)
    get solid_queue_recurring_task_path(recurring_task)

    assert_response :unauthorized
  end

  test "GET show, redirects if Solid Queue is not available" do
    batch = solid_queue_batches(:successful_batch)

    authenticated_in_dummy_app do
      SolidTaxi::SolidQueue.stub(:version, nil) do
        get solid_queue_batch_executions_path(batch)
      end

      assert_response :redirect

      follow_redirect!

      assert_response :success

      assert_dom("p", "Welcome to Solid Taxi!")
    end
  end

  test "GET show, authorized" do
    recurring_task = solid_queue_recurring_tasks(:random)

    authenticated_in_dummy_app do
      get solid_queue_recurring_task_path(recurring_task)

      assert_response :success
      assert_dom("h1", "Solid Taxi navigation")
      assert_dom("h2", "Solid Queue")
      assert_dom("h3", "Solid Queue Navigation")
      assert_dom("h4", "Recurring Task")
      assert_dom("h5", "Solid Queue Recurring Task Navigation")
      assert_dom("h6", "About")
    end
  end
end
