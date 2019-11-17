class Subject < ApplicationRecord
	
    validates :name, :code,  presence: true
	validates :name, :code, :teacher_id, uniqueness: { case_sensitive: false }

	belongs_to :teacher, class_name: 'User'

	has_many :marks
	has_many :students, through: :marks	



end
