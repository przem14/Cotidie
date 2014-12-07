class Degree < ActiveRecord::Base
  belongs_to :subject
  belongs_to :student, class_name: "User"
end
