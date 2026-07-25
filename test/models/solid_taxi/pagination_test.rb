require "test_helper"

class SolidTaxi::PaginationTest < ActiveSupport::TestCase
  test "no pagination params" do
    params = ActionController::Parameters.new
    pagination = SolidTaxi::Pagination.new(params)

    assert_equal 50, pagination.limit
    assert_equal Float::INFINITY, pagination.total_pages
    assert_equal 1, pagination.page
    assert_equal 0, pagination.offset
    assert_equal true, pagination.first_page?
    assert_equal false, pagination.last_page?

    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.first_page_url_params)
    assert_equal({ query: {}, pagination: { page: 0 } }, pagination.previous_page_url_params)
    assert_equal({ query: {}, pagination: { page: 2 } }, pagination.next_page_url_params)
    assert_equal({ query: {}, pagination: { page: Float::INFINITY } }, pagination.last_page_url_params)
    assert_equal({ query: {} }, pagination.pagination_link_params)

    assert_equal({}, pagination.query_params)
  end

  test "no pagination params, total_rows: 0" do
    params = ActionController::Parameters.new
    pagination = SolidTaxi::Pagination.new(params, total_rows: 0)

    assert_equal 50, pagination.limit
    assert_equal 0, pagination.total_pages
    assert_equal 0, pagination.page
    assert_equal 0, pagination.offset
    assert_equal false, pagination.first_page?
    assert_equal false, pagination.last_page?

    assert_equal({ query: {}, pagination: { page: 0 } }, pagination.first_page_url_params)
    assert_equal({ query: {}, pagination: { page: 0 } }, pagination.previous_page_url_params)
    assert_equal({ query: {}, pagination: { page: 0 } }, pagination.next_page_url_params)
    assert_equal({ query: {}, pagination: { page: 0 } }, pagination.last_page_url_params)
    assert_equal({ query: {} }, pagination.pagination_link_params)

    assert_equal({}, pagination.query_params)
  end

  test "no pagination params, total_rows: 1" do
    params = ActionController::Parameters.new
    pagination = SolidTaxi::Pagination.new(params, total_rows: 1)

    assert_equal 50, pagination.limit
    assert_equal 1, pagination.total_pages
    assert_equal 1, pagination.page
    assert_equal 0, pagination.offset
    assert_equal true, pagination.first_page?
    assert_equal true, pagination.last_page?

    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.first_page_url_params)
    assert_equal({ query: {}, pagination: { page: 0 } }, pagination.previous_page_url_params)
    assert_equal({ query: {}, pagination: { page: 2 } }, pagination.next_page_url_params)
    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.last_page_url_params)
    assert_equal({ query: {} }, pagination.pagination_link_params)

    assert_equal({}, pagination.query_params)
  end

  test "page 1, total_rows: 1" do
    params = ActionController::Parameters.new(pagination: { page: 1 })
    pagination = SolidTaxi::Pagination.new(params, total_rows: 1)

    assert_equal 50, pagination.limit
    assert_equal 1, pagination.total_pages
    assert_equal 1, pagination.page
    assert_equal 0, pagination.offset
    assert_equal true, pagination.first_page?
    assert_equal true, pagination.last_page?

    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.first_page_url_params)
    assert_equal({ query: {}, pagination: { page: 0 } }, pagination.previous_page_url_params)
    assert_equal({ query: {}, pagination: { page: 2 } }, pagination.next_page_url_params)
    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.last_page_url_params)
    assert_equal({ query: {} }, pagination.pagination_link_params)

    assert_equal({}, pagination.query_params)
  end

  test "page 2, total_rows: 1, out-of-bounds" do
    params = ActionController::Parameters.new(pagination: { page: 2 })
    pagination = SolidTaxi::Pagination.new(params, total_rows: 1)

    assert_equal 50, pagination.limit
    assert_equal 1, pagination.total_pages
    assert_equal 1, pagination.page
    assert_equal 0, pagination.offset
    assert_equal true, pagination.first_page?
    assert_equal true, pagination.last_page?

    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.first_page_url_params)
    assert_equal({ query: {}, pagination: { page: 0 } }, pagination.previous_page_url_params)
    assert_equal({ query: {}, pagination: { page: 2 } }, pagination.next_page_url_params)
    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.last_page_url_params)
    assert_equal({ query: {} }, pagination.pagination_link_params)

    assert_equal({}, pagination.query_params)
  end

  test "page 2, total_rows: 51" do
    params = ActionController::Parameters.new(pagination: { page: 2 })
    pagination = SolidTaxi::Pagination.new(params, total_rows: 51)

    assert_equal 50, pagination.limit
    assert_equal 2, pagination.total_pages
    assert_equal 2, pagination.page
    assert_equal 50, pagination.offset
    assert_equal false, pagination.first_page?
    assert_equal true, pagination.last_page?

    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.first_page_url_params)
    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.previous_page_url_params)
    assert_equal({ query: {}, pagination: { page: 3 } }, pagination.next_page_url_params)
    assert_equal({ query: {}, pagination: { page: 2 } }, pagination.last_page_url_params)
    assert_equal({ query: {} }, pagination.pagination_link_params)

    assert_equal({}, pagination.query_params)
  end

  test "page 2, total_rows: 101" do
    params = ActionController::Parameters.new(pagination: { page: 2 })
    pagination = SolidTaxi::Pagination.new(params, total_rows: 101)

    assert_equal 50, pagination.limit
    assert_equal 3, pagination.total_pages
    assert_equal 2, pagination.page
    assert_equal 50, pagination.offset
    assert_equal false, pagination.first_page?
    assert_equal false, pagination.last_page?

    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.first_page_url_params)
    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.previous_page_url_params)
    assert_equal({ query: {}, pagination: { page: 3 } }, pagination.next_page_url_params)
    assert_equal({ query: {}, pagination: { page: 3 } }, pagination.last_page_url_params)
    assert_equal({ query: {} }, pagination.pagination_link_params)

    assert_equal({}, pagination.query_params)
  end

  test "page 3, total_rows: 101" do
    params = ActionController::Parameters.new(pagination: { page: 3 })
    pagination = SolidTaxi::Pagination.new(params, total_rows: 101)

    assert_equal 50, pagination.limit
    assert_equal 3, pagination.total_pages
    assert_equal 3, pagination.page
    assert_equal 100, pagination.offset
    assert_equal false, pagination.first_page?
    assert_equal true, pagination.last_page?

    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.first_page_url_params)
    assert_equal({ query: {}, pagination: { page: 2 } }, pagination.previous_page_url_params)
    assert_equal({ query: {}, pagination: { page: 4 } }, pagination.next_page_url_params)
    assert_equal({ query: {}, pagination: { page: 3 } }, pagination.last_page_url_params)
    assert_equal({ query: {} }, pagination.pagination_link_params)

    assert_equal({}, pagination.query_params)
  end

  test "page 4, total_rows: 101, out-of-bounds" do
    params = ActionController::Parameters.new(pagination: { page: 4 })
    pagination = SolidTaxi::Pagination.new(params, total_rows: 101)

    assert_equal 50, pagination.limit
    assert_equal 3, pagination.total_pages
    assert_equal 3, pagination.page
    assert_equal 100, pagination.offset
    assert_equal false, pagination.first_page?
    assert_equal true, pagination.last_page?

    assert_equal({ query: {}, pagination: { page: 1 } }, pagination.first_page_url_params)
    assert_equal({ query: {}, pagination: { page: 2 } }, pagination.previous_page_url_params)
    assert_equal({ query: {}, pagination: { page: 4 } }, pagination.next_page_url_params)
    assert_equal({ query: {}, pagination: { page: 3 } }, pagination.last_page_url_params)
    assert_equal({ query: {} }, pagination.pagination_link_params)

    assert_equal({}, pagination.query_params)
  end
end
