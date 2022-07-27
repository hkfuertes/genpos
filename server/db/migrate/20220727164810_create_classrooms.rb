class CreateClassrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :classrooms do |t|
      t.string :level
      t.string :letter
      t.string :subject

      t.timestamps
    end
  end
end
