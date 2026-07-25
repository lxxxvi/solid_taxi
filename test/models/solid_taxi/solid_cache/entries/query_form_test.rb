require "test_helper"

class SolidTaxi::SolidCache::Entries::QueryFormTest < ActiveSupport::TestCase
  test "form_fields" do
    params = ActionController::Parameters.new(
      query: {
        key: "key",
        value: "value",
        key_hash: "key_hash",
        byte_size_from: "100",
        byte_size_to: "200",
        created_at_from: "2000-05-01T12:00",
        created_at_to: "2000-05-01T13:00"
      }
    )

    SolidTaxi::SolidCache::Entries::Page.new(params).query_form.tap do |query_form|
      assert_equal "key", query_form.key
      assert_equal "value", query_form.value
      assert_equal "key_hash", query_form.key_hash
      assert_equal "100", query_form.byte_size_from
      assert_equal "200", query_form.byte_size_to
      assert_equal "2000-05-01T12:00", query_form.created_at_from
      assert_equal "2000-05-01T13:00", query_form.created_at_to
    end
  end
end
