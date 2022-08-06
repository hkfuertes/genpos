class TeacherAddAdminBool < ActiveRecord::Migration[7.0]
  def change
    add_column :teachers, :admin, :boolean
  end
end
