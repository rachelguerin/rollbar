class AttackController < ApplicationController
	skip_before_action :verify_authenticity_token
	
	def attack
		@attackmode = params['_json'][0]['attackmode']
		@radar = params['_json'][0]['radar']

		Position.loadData(@radar)

		render json: Position.get(@attackmode)

	end
end
