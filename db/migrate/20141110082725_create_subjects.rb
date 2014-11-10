class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.references :school_class
      t.references :teacher

      t.timestamps
    end
  end
end
