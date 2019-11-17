class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :roll_number
      t.date :dob
      t.string :gender
      t.string :contact_number
      t.timestamps
    end
  end
end
