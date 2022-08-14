class CreateAssestments < ActiveRecord::Migration[7.0]
  def change
    # classroom_id, student_id, assestment = [{id => (1|0|-1)}]
    create_table :assestments do |t|
      t.references :classroom, foreign_key: true
      t.references :student, foreign_key: true
      t.json :assestments
      t.timestamps
    end
    add_index :assestments, %i[classroom_id student_id], unique: true
  end
end
