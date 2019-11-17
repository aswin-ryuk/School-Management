class CreateMarks < ActiveRecord::Migration[5.0]
  def change
    create_table :marks do |t|
      t.integer :subject_id
      t.integer :student_id
      t.integer :subject_mark
    end
  end
end
