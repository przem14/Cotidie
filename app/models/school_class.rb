class SchoolClass < ActiveRecord::Base
  has_many :subjects, dependent: :destroy
  has_many :students, class_name: "User", foreign_key: "student_class_id", dependent: :nullify
  belongs_to :teacher, class_name: "User"

  validates :name, presence: true, format: { with: /\A[1-6][a-zA-Z]\z/ }
end
