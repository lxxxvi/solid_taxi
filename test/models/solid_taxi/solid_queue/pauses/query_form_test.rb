require "test_helper"

class SolidTaxi::SolidQueue::Pauses::QueryFormTest < ActiveSupport::TestCase
  test "form_fields" do
    params = ActionController::Parameters.new(
      query: {
        queue_name: "pause-queue_name"
      }
    )

    SolidTaxi::SolidQueue::Pauses::Page.new(params).query_form.tap do |query_form|
      assert_equal "pause-queue_name", query_form.queue_name
    end
  end
end
