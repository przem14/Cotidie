class SchoolClass < ActiveRecord::Base
  has_many :subjects, dependent: :destroy
  has_many :students, class_name: "User", foreign_key: "student_class_id", dependent: :nullify
  belongs_to :teacher, class_name: "User"

  validates :name, presence: true, format: { with: /\A[1-6][a-zA-Z]\z/ }

  def permitted_students(current_user)
    if current_user.role == 'student'
      [current_user]
    elsif current_user.role == 'tutor'
      [current_user.student]
    else
      students
    end
  end
end
