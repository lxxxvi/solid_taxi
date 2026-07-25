require "test_helper"

class SolidTaxi::SolidQueue::Processes::PageTest < ActiveSupport::TestCase
  test ".new" do
    SolidTaxi::SolidQueue::Processes::Page.new.tap do |page|
      assert_equal SolidTaxi::SolidQueue::Processes::QueryForm, page.query_form.class
      assert_equal SolidTaxi::Pagination, page.pagination.class
      assert_equal SolidTaxi::SolidQueue::Processes::Query, page.query.class
    end
  end
end
