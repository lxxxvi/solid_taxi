require "test_helper"

class SolidTaxi::SolidCache::Entries::PageTest < ActiveSupport::TestCase
  test ".new" do
    SolidTaxi::SolidCache::Entries::Page.new.tap do |page|
      assert_equal SolidTaxi::SolidCache::Entries::QueryForm, page.query_form.class
      assert_equal SolidTaxi::Pagination, page.pagination.class
      assert_equal SolidTaxi::SolidCache::Entries::Query, page.query.class
    end
  end
end
