class StudentClassroom < ActiveRecord::Migration[7.0]
  def change
    create_table :student_classroom do |t|
      t.references :student, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true
      t.timestamps
    end
  end
end
