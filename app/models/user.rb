class User < ActiveRecord::Base
  has_one :student, class_name: "User", foreign_key: "tutor_id"

  belongs_to :tutor, class_name: "User"
  belongs_to :student_class, class_name: "SchoolClass"
  has_many :degrees, class_name: "Degree", foreign_key: "student_id"

  has_one :teacher_class, class_name: "SchoolClass", foreign_key: "teacher_id"
  has_many :subjects, class_name: "Subject", foreign_key: "teacher_id"

  validates :name, presence: true
  validates :surname, presence: true
  validates :personal_id, presence: true
  validates :personal_id, length: {is:11}
  validates :personal_id, numericality: true

  after_initialize :set_not_approved

  enum role: [:teacher, :student, :tutor, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{name} #{surname}"
  end

  def degrees_by_subject(subject_id)
    degrees.where(:subject_id => subject_id)
  end

private
  def set_not_approved
    self.is_approved ||= false
  end
end
