class AddReferencesToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :student_class, index: true
    add_reference :users, :tutor, index: true
  end
end
