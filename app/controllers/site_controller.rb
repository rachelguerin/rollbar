class SiteController < ApplicationController
	skip_before_action :verify_authenticity_token
	
	def home
		render 'home'
	end

end
