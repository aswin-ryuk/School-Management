module ApplicationHelper

	def submit_btn_text
		return  ['new','create'].include?(params[:action]) ? 'Save' : 'Update'
	end
	
end
