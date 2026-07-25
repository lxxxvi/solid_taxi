class SolidTaxi::Page
  attr_reader :params

  def initialize(params = ActionController::Parameters.new)
    @params = params
  end

  def query_form
    @query_form ||= query_form_klass.new(self)
  end

  def pagination
    @pagination ||= SolidTaxi::Pagination.new(params, total_rows: query.total_rows)
  end

  def query
    @query ||= query_klass.new(self)
  end

  private

  def query_form_klass
    "#{page_klass_root}::QueryForm".constantize
  end

  def query_klass
    "#{page_klass_root}::Query".constantize
  end

  def page_klass_root
    @page_klass_root ||= self.class.to_s.sub(/::Page\z/, "")
  end
end
