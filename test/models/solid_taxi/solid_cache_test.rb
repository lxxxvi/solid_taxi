require "test_helper"

class SolidTaxi::SolidCacheTest < ActiveSupport::TestCase
  test "class_methods, present" do
    assert_equal "1.0.10", SolidTaxi::SolidCache.version
    assert_equal true, SolidTaxi::SolidCache.present?
  end

  test "class_methods, not present" do
    SolidTaxi::SolidCache.stub(:version, nil) do
      assert_nil SolidTaxi::SolidCache.version
      assert_equal false, SolidTaxi::SolidCache.present?
    end
  end
end
