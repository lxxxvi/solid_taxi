require "test_helper"

class SolidTaxi::SolidQueue::Jobs::PageTest < ActiveSupport::TestCase
  test ".new" do
    SolidTaxi::SolidQueue::Jobs::Page.new.tap do |page|
      assert_equal SolidTaxi::SolidQueue::Jobs::QueryForm, page.query_form.class
      assert_equal SolidTaxi::Pagination, page.pagination.class
      assert_equal SolidTaxi::SolidQueue::Jobs::Query, page.query.class
    end
  end
end
