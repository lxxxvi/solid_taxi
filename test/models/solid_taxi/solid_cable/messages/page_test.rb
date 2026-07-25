require "test_helper"

class SolidTaxi::SolidCable::Messages::PageTest < ActiveSupport::TestCase
  test ".new" do
    SolidTaxi::SolidCable::Messages::Page.new.tap do |page|
      assert_equal SolidTaxi::SolidCable::Messages::QueryForm, page.query_form.class
      assert_equal SolidTaxi::Pagination, page.pagination.class
      assert_equal SolidTaxi::SolidCable::Messages::Query, page.query.class
    end
  end
end
