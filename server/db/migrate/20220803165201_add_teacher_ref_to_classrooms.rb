class AddTeacherRefToClassrooms < ActiveRecord::Migration[7.0]
  def change
    add_reference :classrooms, :teacher, foreign_key: true
  end
end
