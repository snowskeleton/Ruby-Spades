#!/bin/ruby

require 'sqlite3'

class Player
	attr_accessor :name, :bid, :tricks, :team, :blind
	def initialize(name)
		@name = name
	end
end

class Gather
	def player_list(number)
		@player_list = []
		num = 1

		number.times {
		puts "Who is player " + num.to_s + "?"
		player = gets.chomp
		player = Player.new(player)
		@player_list.push(player)
		num += 1
		}

		return @player_list
	end
	def bids(player)
		input = gets.chomp
		player.bid= input
	end
end


player_array = Gather.new.player_list(4)

player_array.each do |title|
	puts title.name
end

player_array.each do |player|
	Gather.new.bids(player)
end
player_array.each do |title|
	puts title.bid
end



########################################
#class Data

#	def initialize()
		#db = SQLite3::Database.open 'playerbase.db'
		#db.results_as_hash = true
#	end
#end


#db = SQLite3::Database.open 'playerbase.db'
#db.results_as_hash = true
#db.execute "DROP TABLE IF EXISTS players"
#db.execute "DROP TABLE IF EXISTS teams"
#db.close
#db.execute "CREATE TABLE IF NOT EXISTS players (name TEXT, bid INT, blind INT, tricks_taken INT, team TEXT, dealer INT default 0)"
#db.execute "CREATE TABLE IF NOT EXISTS teams (name TEXT, total_bid INT, tricks_taken INT, bags INT DEFAULT 0, score INT DEFAULT 0)"
#db.execute "INSERT INTO players (name) VALUES(?)", 'isaac'
#db.close
