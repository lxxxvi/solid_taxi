require "test_helper"

class SolidTaxi::RailsTest < ActiveSupport::TestCase
  test "class_methods, present" do
    assert_equal "8.1.3.1", SolidTaxi::Rails.version
    assert_equal true, SolidTaxi::Rails.present?
  end

  test "class_methods, not present" do
    SolidTaxi::Rails.stub(:version, nil) do
      assert_nil SolidTaxi::Rails.version
      assert_equal false, SolidTaxi::Rails.present?
    end
  end
end
