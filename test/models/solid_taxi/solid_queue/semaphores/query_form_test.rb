require "test_helper"

class SolidTaxi::SolidQueue::Semaphores::QueryFormTest < ActiveSupport::TestCase
  test "form_fields" do
    params = ActionController::Parameters.new(
      query: {
        key: "semaphore-key",
        value_from: "34300",
        value_to: "34400",
        expires_at_from: "2000-03-02T12:00",
        expires_at_to: "2000-03-02T13:00"
      }
    )

    SolidTaxi::SolidQueue::Semaphores::Page.new(params).query_form.tap do |query_form|
      assert_equal "semaphore-key", query_form.key
      assert_equal "34300", query_form.value_from
      assert_equal "34400", query_form.value_to
      assert_equal "2000-03-02T12:00", query_form.expires_at_from
      assert_equal "2000-03-02T13:00", query_form.expires_at_to
    end
  end
end
