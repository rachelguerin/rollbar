class Position < ApplicationRecord
	has_many :targets, dependent: :destroy

	def self.loadData(radar)
		Position.destroy_all
		Target.destroy_all
		radar.each do |pos|
			x = pos['position']['x'] 
			y = pos['position']['y'] 
			p = Position.create x:x, y:y
			pos['targets'].each do |target|
				typename = target['type']
				damage = target['damage']
				p.targets.create typename:typename, damage:damage
			end
		end
	end

	def self.get(attackmode)
		ret = {}
		attackmode.each do |a|
			ret = self.send(a)
		end

		return ret
	end

	def self.closest_first
		by_closest = Position.all.sort_by {|p| [p.x,p.y]}
		closest = by_closest[0]

		return self.get_attack(closest)
	end

	def self.furthest_first
		by_furthest = Position.all.sort_by {|p| [p.x,p.y]}.reverse
		furthest = by_furthest[0]
	
		return self.get_attack(furthest)
	end

	def self.avoid_crossfire
		Position.all.each do |p|
			if p.targets.map {|t| t.typename }.include?('Human')
				p.destroy
			end
		end	
	end

	def self.priorize_t_x
		tx_only = Position.all.select {|p| p.targets.map{|t| t.typename}.include?('T-X')}
	
		return self.get_attack(tx_only[0])
	end

	def self.get_attack(ts)
		if ts != nil
			attack = {
				'position': {
					'x': ts.x,
					'y': ts.y
				},
				'targets': ts.targets.map {|t| t.typename }.select {|t| t != 'Human'}
			}
			return attack
		else
			return "error no tx"
		end
	end
end
