class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :classrooms, dependent: :nullify

  def full_name
    [name, last_name].join(' ')
  end

  def admin?
    admin
  end

  def promote
    admin = true  
  end

  def demote
    admin = false
  end
end
