class Student < ApplicationRecord

	validates :name, :dob, :gender, :contact_number, :roll_number,  presence: true
	validates :contact_number, length: {maximum: 10}

	validates :roll_number, uniqueness: true

	GENDER = [['Male', 'M'],['Female', 'F']]

	has_many :subjects, through: :marks	
	has_many :marks	

	accepts_nested_attributes_for :marks

end
