class SolidTaxi::QueryForm
  include SolidTaxi::QueryForm::FormFields

  def initialize(page)
    @page = page
  end

  def model_name
    ActiveModel::Name.new(self, nil, "Query")
  end

  def any_queries?
    query_params.values.any?(&:present?)
  end

  private

  attr_reader :page, :form_field_names

  def params
    page.params
  end

  def query_params
    return @query_params if defined?(@query_params)

    @query_params = if params.key?(:query)
      params.require(:query).permit(self.class.form_field_names)
    else
      {}
    end
  end
end
