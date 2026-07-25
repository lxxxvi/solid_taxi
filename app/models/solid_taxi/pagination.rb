class SolidTaxi::Pagination
  include AbstractController::Helpers

  DEFAULTS = {
    page: 1,
    limit: 50
  }
  MAX_LIMIT = 1000

  def initialize(params, total_rows: Float::INFINITY)
    @params = params
    @total_rows = total_rows
  end

  def limit
    @limit ||= pagination_params[:limit].clamp(0, MAX_LIMIT)
  end

  def total_pages
    @total_pages ||= total_rows == Float::INFINITY ? Float::INFINITY : (total_rows / limit.to_f).ceil
  end

  def page
    @page ||= pagination_params[:page].clamp(0, total_pages)
  end

  def offset
    @offset ||= ((page - 1).clamp(0, Float::INFINITY)) * limit
  end

  def first_page?
    page == 1
  end

  def last_page?
    page == total_pages && total_pages != 0
  end

  def first_page_url_params
    first_page = [ page, 1 ].min # 0 or 1
    pagination_link_params.merge(pagination: { page: first_page })
  end

  def previous_page_url_params
    pagination_link_params.merge(pagination: { page: page.pred.clamp(0, Float::INFINITY) })
  end

  def next_page_url_params
    next_page = page == 0 ? 0 : page.succ # 0 if page is 0
    pagination_link_params.merge(pagination: { page: next_page })
  end

  def last_page_url_params
    pagination_link_params.merge(pagination: { page: total_pages })
  end

  def pagination_link_params
    { query: query_params }
  end

  def query_params
    return params[:query].permit! if params.key?(:query)

    {}
  end

  private

  attr_reader :params, :total_rows

  def pagination_params
    @pagination_params ||= find_and_transform_params
  end

  def find_and_transform_params
    return DEFAULTS if !params.key?(:pagination)

    params
      .require(:pagination)
      .permit(:page, :limit)
      .transform_values(&:to_i)
      .to_h
      .symbolize_keys
      .with_defaults(DEFAULTS)
  end
end
