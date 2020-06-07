#!/bin/ruby
require 'sqlite3'

class Player
	attr_accessor :name, :bid, :tricks, :team, :blind

	def initialize(name)
		@name = name
	end
end #Player

class Team
	attr_accessor :players, :bid, :tricks, :bags, :score

	def initialize(players)
		@players[] = players
	end
end #Team

class Gather
	def players(number)
		@player_array = []
		num = 1

		number.times {
		print "Who is player " + num.to_s + "? "
		player = gets.chomp
		player = Player.new(player)
		@player_array.push(player)
		num += 1
		}
		puts #newline

		return @player_array
	end

	def bids(player)
		num = 1
		print "What is " + player.name + "'s bid? "
		input = gets.chomp
		player.bid= input
	end
end #Gather


player_array = Gather.new.players(4)

dealer_count = rand(1..4)
player_array.rotate!(dealer_count)
player_array.each do |title|
	puts title.name
end

#player_array.each do |player|
	#Gather.new.bids(player)
#end
#player_array.each do |title|
	#puts title.bid
#end



########################################
#class Data

#	def initialize()
		#db = SQLite3::Database.open 'playerbase.db'
		#db.results_as_hash = true
		#db.close
#	end
#end
