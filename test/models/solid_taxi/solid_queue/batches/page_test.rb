require "test_helper"

class SolidTaxi::SolidQueue::Batches::PageTest < ActiveSupport::TestCase
  test ".new" do
    SolidTaxi::SolidQueue::Batches::Page.new.tap do |page|
      assert_equal SolidTaxi::SolidQueue::Batches::QueryForm, page.query_form.class
      assert_equal SolidTaxi::Pagination, page.pagination.class
      assert_equal SolidTaxi::SolidQueue::Batches::Query, page.query.class
    end
  end
end
