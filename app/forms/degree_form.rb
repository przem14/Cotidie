class DegreeForm
  include ActiveModel::Model

  attr_accessor :value
  attr_accessor :activity
  attr_accessor :description

  validates :value, presence: true, format: { with: /\A([1][+]?|[2-5][+-]?|[6][-]?)\z/ }
  validates :activity, presence: true, length: { maximum: 25 }
  validates :description, length: { maximum: 200 }
end