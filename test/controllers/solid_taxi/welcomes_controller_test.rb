require "test_helper"

class SolidTaxi::WelcomesControllerTest < ActionDispatch::IntegrationTest
  test "GET index, unauthorized" do
    get root_path
    assert_response :unauthorized
  end

  test "GET index, authorized" do
    authenticated_in_dummy_app do
      get root_path
      assert_response :success

      assert_dom("h1", "Solid Taxi navigation")
      assert_dom("h2", "Solid Taxi")

      assert_select("nav a", "Solid Cable")
      assert_select("nav a", "Solid Cache")
      assert_select("nav a", "Solid Queue")

      assert_select(":not(nav) > ul a", "Solid Cable (4.0.2)")
      assert_select(":not(nav) > ul a", "Solid Cache (1.0.10)")
      assert_select(":not(nav) > ul a", "Solid Queue (1.7.0)")
    end
  end

  test "GET index, authorized, no Solid Cable" do
    authenticated_in_dummy_app do
      SolidTaxi::SolidCable.stub(:version, nil) do
        get root_path
      end
      assert_response :success

      assert_dom("h1", "Solid Taxi navigation")
      assert_dom("h2", "Solid Taxi")

      assert_select("nav a", count: 2)
      assert_select("nav a", "Solid Cache")
      assert_select("nav a", "Solid Queue")

      assert_select(":not(nav) > ul a", count: 2)
      assert_select(":not(nav) > ul a", "Solid Cache (1.0.10)")
      assert_select(":not(nav) > ul a", "Solid Queue (1.7.0)")
    end
  end

  test "GET index, authorized, no Solid Cache" do
    authenticated_in_dummy_app do
      SolidTaxi::SolidCache.stub(:version, nil) do
        get root_path
      end
      assert_response :success

      assert_dom("h1", "Solid Taxi navigation")
      assert_dom("h2", "Solid Taxi")

      assert_select("nav a", count: 2)
      assert_select("nav a", "Solid Cable")
      assert_select("nav a", "Solid Queue")

      assert_select(":not(nav) > ul a", count: 2)
      assert_select(":not(nav) > ul a", "Solid Cable (4.0.2)")
      assert_select(":not(nav) > ul a", "Solid Queue (1.7.0)")
    end
  end

  test "GET index, authorized, no Solid Queue" do
    authenticated_in_dummy_app do
      SolidTaxi::SolidQueue.stub(:version, nil) do
        get root_path
      end
      assert_response :success

      assert_dom("h1", "Solid Taxi navigation")
      assert_dom("h2", "Solid Taxi")

      assert_select("nav a", count: 2)
      assert_select("nav a", "Solid Cable")
      assert_select("nav a", "Solid Cache")

      assert_select(":not(nav) > ul a", count: 2)
      assert_select(":not(nav) > ul a", "Solid Cable (4.0.2)")
      assert_select(":not(nav) > ul a", "Solid Cache (1.0.10)")
    end
  end

  test "GET index, authorized, no Solid Stack" do
    authenticated_in_dummy_app do
      SolidTaxi::SolidQueue.stub(:version, nil) do
        SolidTaxi::SolidCache.stub(:version, nil) do
          SolidTaxi::SolidCable.stub(:version, nil) do
            get root_path
          end
        end
      end
      assert_response :success

      assert_dom("h1", count: 0)
      assert_dom("h2", "Solid Taxi")

      assert_select("nav", count: 0)
      assert_select("ul", count: 0)

      assert_select("p", "You don't seem to have any of the Solid Stack gems installed.")
      assert_select("p", "Make sure you either have solid_cable, solid_cache and/or solid_queue installed.")
      assert_select("p", "If you don't want any of these, you can uninstall/remove solid_taxi from your bundle again.")
    end
  end
end
