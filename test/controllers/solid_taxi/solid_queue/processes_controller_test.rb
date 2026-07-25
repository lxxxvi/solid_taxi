require "test_helper"

class SolidTaxi::SolidQueue::ProcessesControllerTest < ActionDispatch::IntegrationTest
  test "GET index, unauthorized" do
    get solid_queue_processes_path

    assert_response :unauthorized
  end

  test "GET index, redirects if Solid Queue is not available" do
    authenticated_in_dummy_app do
      SolidTaxi::SolidQueue.stub(:version, nil) do
        get solid_queue_processes_path
      end

      assert_response :redirect

      follow_redirect!

      assert_response :success

      assert_dom("p", "Welcome to Solid Taxi!")
    end
  end

  test "GET index, authorized" do
    authenticated_in_dummy_app do
      get solid_queue_processes_path

      assert_response :success
      assert_dom("h1", "Solid Taxi navigation")
      assert_dom("h2", "Solid Queue")
      assert_dom("h3", "Solid Queue Navigation")
      assert_dom("h4", "Processes")
      refute_dom("h5")
    end
  end
end
