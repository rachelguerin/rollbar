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
		ret = Position.all
		attackmode.each do |a|
			ret = self.send(a.gsub(/[-]/,'_'),ret)
		end
		return self.get_attack(ret[0])
	end

	def self.closest_first(pos)
		return pos.sort_by {|p| p.x+p.y}
	end

	def self.furthest_first(pos)
		return pos.sort_by {|p| p.x+p.y}.reverse
	end

	def self.avoid_crossfire(pos)
		return pos.select! {|p| !p.targets.map{|t| t.typename}.include?('Human')}
	end

	def self.priorize_t_x(pos)
		tx_only = pos.select {|p| p.targets.map{|t| t.typename}.include?('T-X')}
	
		if !tx_only.nil? && !tx_only.empty? 
			return tx_only
		else
			return self.closest_first(pos)
		end
	end

	def self.get_attack(ts)
		attack = {
			'position': {
				'x': ts.x,
				'y': ts.y
			},
			'targets': ts.targets.map {|t| t.typename }.select {|t| t != 'Human'}
		}
		return attack

	end
end
