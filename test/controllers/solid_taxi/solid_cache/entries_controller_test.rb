require "test_helper"

class SolidTaxi::SolidCache::EntriesControllerTest < ActionDispatch::IntegrationTest
  test "GET index, unauthorized" do
    get solid_cache_entries_path
    assert_response :unauthorized
  end

  test "GET index, redirects if Solid Cache is not available" do
    authenticated_in_dummy_app do
      SolidTaxi::SolidCache.stub(:version, nil) do
        get solid_cache_entries_path
      end

      assert_response :redirect

      follow_redirect!

      assert_response :success

      assert_dom("p", "Welcome to Solid Taxi!")
    end
  end

  test "GET index, authorized" do
    authenticated_in_dummy_app do
      get solid_cache_entries_path
      assert_response :success

      assert_dom("h1", "Solid Taxi navigation")
      assert_dom("h2", "Solid Cache")
      assert_dom("h3", "Entries")
      refute_dom("h4")
    end
  end
end
