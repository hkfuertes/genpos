class AddIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :classrooms, %i[level letter subject], unique: true
  end
end
