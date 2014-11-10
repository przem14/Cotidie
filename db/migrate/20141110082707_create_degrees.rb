class CreateDegrees < ActiveRecord::Migration
  def change
    create_table :degrees do |t|
      t.string :value
      t.string :activity
      t.text :description
      t.references :student
      t.references :subject

      t.timestamps
    end
  end
end
