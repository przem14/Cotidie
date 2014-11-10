class Degree < ActiveRecord::Base
  belongs_to :subject
  belongs_to :student, class_name: "User"

  validates :value, presence: true, format: { with: /\A([1][+]?|[2-5][+-]?|[6][-]?)\z/ }
  validates :activity, presence: true, length: { maximum: 25 }
  validates :description, length: { maximum: 200 }
end
