module SolidTaxi::QueryForm::FormFields
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def form_fields(*form_field_names)
      @form_field_names = form_field_names

      instance_eval do
        form_field_names.each do |form_field_name|
          define_method(form_field_name) do
            query_params[form_field_name]
          end
        end
      end
    end

    def form_field_names
      @form_field_names || []
    end
  end
end
