class Mark < ApplicationRecord

	validate :check_subject_mark

	attr_accessor :sub_name

	belongs_to :student	
	belongs_to :subject

	def check_subject_mark
		if self.subject_mark.to_i > 100
			self.errors.add(:base,"should be lesser or equal to 100")
		end
	end

end


