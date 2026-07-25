require "test_helper"

class SolidTaxi::SolidQueueTest < ActiveSupport::TestCase
  test "class_methods, present, latest" do
    assert_equal "1.7.0", SolidTaxi::SolidQueue.version
    assert_equal true, SolidTaxi::SolidQueue.present?
    assert_equal true, SolidTaxi::SolidQueue.supports_batches?
    assert_equal true, SolidTaxi::SolidQueue.gte_v1_7?
  end

  test "class_methods, present, v1.6.1" do
    SolidTaxi::SolidQueue.stub(:version, "1.6.1") do
      assert_equal "1.6.1", SolidTaxi::SolidQueue.version
      assert_equal true, SolidTaxi::SolidQueue.present?
      assert_equal false, SolidTaxi::SolidQueue.supports_batches?
      assert_equal false, SolidTaxi::SolidQueue.gte_v1_7?
    end
  end

  test "class_methods, present, v1.5.0" do
    SolidTaxi::SolidQueue.stub(:version, "1.5.0") do
      assert_equal "1.5.0", SolidTaxi::SolidQueue.version
      assert_equal true, SolidTaxi::SolidQueue.present?
      assert_equal false, SolidTaxi::SolidQueue.supports_batches?
      assert_equal false, SolidTaxi::SolidQueue.gte_v1_7?
    end
  end

  test "class_methods, not present" do
    SolidTaxi::SolidQueue.stub(:version, nil) do
      assert_nil SolidTaxi::SolidQueue.version
      assert_equal false, SolidTaxi::SolidQueue.present?
    end
  end
end
