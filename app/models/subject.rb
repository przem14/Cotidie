class Subject < ActiveRecord::Base
  belongs_to :school_class
  belongs_to :teacher, class_name: "User"
  has_many :degrees

  validates :name, presence: true, length: { in: 2..30 }
end
