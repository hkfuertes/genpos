class Classroom < ApplicationRecord
  has_many :student_classroom
  has_many :students, through: :student_classroom
end