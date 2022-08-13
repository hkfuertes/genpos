class Classroom < ApplicationRecord
  has_many :student_classroom
  has_many :students, through: :student_classroom

  belongs_to :teacher

  has_one :assestment
end
