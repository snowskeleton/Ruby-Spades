#!/bin/ruby
class Dealing
	@@start = true

	def self.rotate(players)
		player_array = players

		if @@start == false then
			player_array.rotate!(1)
			print player_array.last.name, + " is dealing next."
		else
			@@start = false
			dealer_count = rand(1..4)
			player_array.rotate!(dealer_count)
			print player_array.last.name, + " is dealing first."
		end
		sleep(1)
		puts #newline
		puts #newline

		return player_array
	end
end
