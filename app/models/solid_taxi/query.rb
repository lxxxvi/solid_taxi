class SolidTaxi::Query
  def initialize(page)
    @page = page
  end

  def scope
    return @scope if defined?(@scope)

    @scope = find_scope
  end

  def rows
    @rows ||= scope.limit(pagination.limit)
                   .offset(pagination.offset)
                   .order(self.class::ORDER_BY)
  end

  def total_rows
    scope.count("1") # we need to provide an argument ("1") to **override** any custom selected fields
  end

  private

  attr_reader :page

  def add_filter(type, column, value)
    return if value.blank?

    case type
    when :exact
      @scope = @scope.where("#{column} = :value", value:)
    when :like
      @scope = @scope.where("#{column} LIKE :value", value: "%#{value}%")
    when :from_number
      @scope = @scope.where("#{column} >= :value", value:)
    when :to_number
      @scope = @scope.where("#{column} <= :value", value:)
    when :from_time
      @scope = @scope.where("#{column} >= :value", value: Time.zone.parse(value))
    when :to_time
      @scope = @scope.where("#{column} < :value", value: Time.zone.parse(value))
    end
  end

  def params
    page.params
  end

  def query_form
    page.query_form
  end

  def pagination
    @pagination ||= SolidTaxi::Pagination.new(params)
  end
end
