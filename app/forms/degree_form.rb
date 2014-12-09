class DegreeForm
  include ActiveModel::Model

  attr_accessor :value
  attr_accessor :activity
  attr_accessor :description
  attr_accessor :student_id
  attr_accessor :subject_id

  ValidationError = Class.new(StandardError)

  validates :value, presence: true, format: { with: /\A([1][+]?|[2-5][+-]?|[6][-]?)\z/ }
  validates :activity, presence: true, length: { maximum: 25 }
  validates :description, length: { maximum: 200 }

  def validate!
    raise ValidationError, errors unless valid?
  end

  def to_hash
    result = Hash.new

    result[:value]       = @value
    result[:description] = @description
    result[:activity]    = @activity
    result[:student_id]  = @student_id
    result[:subject_id]  = @subject_id
    result
  end
end