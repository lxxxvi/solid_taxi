require "test_helper"

class SolidTaxi::SolidQueue::RecurringTasks::PageTest < ActiveSupport::TestCase
  test ".new" do
    SolidTaxi::SolidQueue::RecurringTasks::Page.new.tap do |page|
      assert_equal SolidTaxi::SolidQueue::RecurringTasks::QueryForm, page.query_form.class
      assert_equal SolidTaxi::Pagination, page.pagination.class
      assert_equal SolidTaxi::SolidQueue::RecurringTasks::Query, page.query.class
    end
  end
end
