#!/bin/ruby
class Dealing
	attr_accessor :start
	def initialize
		@start = true
	end

	def rotate(players)
		player_array = players

		if @start == false then
			player_array.rotate!(1)
			print player_array.last.name, + " is dealing next."
		else
			@start = false
			dealer_count = rand(1..4)
			player_array.rotate!(dealer_count)
			print player_array.last.name, + " is dealing first."
		end
		puts #newline
		puts #newline

		return player_array
	end
end
