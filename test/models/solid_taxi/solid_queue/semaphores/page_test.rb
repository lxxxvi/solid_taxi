require "test_helper"

class SolidTaxi::SolidQueue::Semaphores::PageTest < ActiveSupport::TestCase
  test ".new" do
    SolidTaxi::SolidQueue::Semaphores::Page.new.tap do |page|
      assert_equal SolidTaxi::SolidQueue::Semaphores::QueryForm, page.query_form.class
      assert_equal SolidTaxi::Pagination, page.pagination.class
      assert_equal SolidTaxi::SolidQueue::Semaphores::Query, page.query.class
    end
  end
end
