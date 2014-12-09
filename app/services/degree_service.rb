class DegreeService
  def call(degree_forms)
    degree_forms.each { |degree_form| degree_form.validate! }

    ActiveRecord::Base.transaction do
        degree_forms.each { |degree_form| Degree.create!(degree_form.to_hash) }
    end

    true
  rescue DegreeForm.new.class::ValidationError
    false
  end
end