require "test_helper"

class SolidTaxi::SolidCable::Messages::QueryFormTest < ActiveSupport::TestCase
  test "form_fields" do
    params = ActionController::Parameters.new(
      query: {
        channel: "channel",
        payload: "payload",
        channel_hash: "12300000",
        created_at_from: "2000-01-01T12:00",
        created_at_to: "2000-01-01T13:00"
      }
    )

    SolidTaxi::SolidCable::Messages::Page.new(params).query_form.tap do |query_form|
      assert_equal "channel", query_form.channel
      assert_equal "payload", query_form.payload
      assert_equal "12300000", query_form.channel_hash
      assert_equal "2000-01-01T12:00", query_form.created_at_from
      assert_equal "2000-01-01T13:00", query_form.created_at_to
    end
  end
end
