class Student < ApplicationRecord
  has_many :student_classroom
  has_many :classrooms, through: :student_classroom
end
