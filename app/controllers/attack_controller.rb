class AttackController < ApplicationController
	skip_before_action :verify_authenticity_token
	
	def attack
		@attackmode = params['attack-mode']
		@radar = params['radar']

		Position.loadData(@radar)

		render json: Position.get(@attackmode)

	end
end
