class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  validates :role, presence: true

  has_one :subject, foreign_key: 'teacher_id'


  ROLES=[['Admin', 'admin'],['Teacher','teacher']]


  def is_admin?
  	self.role == 'admin'
  end

  def is_teacher?
    self.role == 'teacher'
  end

end
