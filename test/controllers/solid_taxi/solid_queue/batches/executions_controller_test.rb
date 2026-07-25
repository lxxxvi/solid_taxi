require "test_helper"

class SolidTaxi::SolidQueue::Batches::ExecutionsControllerTest < ActionDispatch::IntegrationTest
  test "GET index, unauthorized" do
    batch = solid_queue_batches(:successful_batch)
    get solid_queue_batch_executions_path(batch)

    assert_response :unauthorized
  end

  test "GET index, redirects if Solid Queue is not available" do
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

  test "GET index, authorized" do
    batch = solid_queue_batches(:successful_batch)

    authenticated_in_dummy_app do
      get solid_queue_batch_executions_path(batch)

      assert_response :success
      assert_dom("h1", "Solid Taxi navigation")
      assert_dom("h2", "Solid Queue")
      assert_dom("h3", "Solid Queue Navigation")
      assert_dom("h4", "Batch")
      assert_dom("h5", "Solid Queue Batch Navigation")
      assert_dom("h6", "Batch Executions")
    end
  end
end
