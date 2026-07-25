require "test_helper"

class SolidTaxi::SolidCableTest < ActiveSupport::TestCase
  test "class_methods, present" do
    assert_equal "4.0.2", SolidTaxi::SolidCable.version
    assert_equal true, SolidTaxi::SolidCable.present?
  end

  test "class_methods, not present" do
    SolidTaxi::SolidCable.stub(:version, nil) do
      assert_nil SolidTaxi::SolidCable.version
      assert_equal false, SolidTaxi::SolidCable.present?
    end
  end
end
