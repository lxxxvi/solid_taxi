require "test_helper"

module SolidTaxi
  class Queue::RecurringTasksControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get queue_recurring_tasks_index_url
      assert_response :success
    end
  end
end
