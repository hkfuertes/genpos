class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name, :last_name
      t.date :birthday

      t.timestamps
    end
  end
end
