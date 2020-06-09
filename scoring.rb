#!/bin/ruby
require 'sqlite3'

class Player
	attr_accessor :name, :bid, :tricks, :team, :blind

	def initialize(name)
		@name = name
	end
	def persist()
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('INSERT INTO players(name) VALUES(?)', title.name)
	#	here there be SQL
	end
end

class Team
	attr_accessor :players, :bid, :tricks, :bags, :score

	def initialize(array_of_players, team_name)
		@players[] = players
	end
end

class Gather
	def players(number)
		@player_array = []
		num = 1

		number.times {
			print "Who is player " + num.to_s + "? "
			player = gets.chomp
			player = Player.new(player)
			player.persist
			@player_array.push(player)
			num += 1
		}
		puts #newline

		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		@player_array.each do |title|
			title.
			db.execute('INSERT INTO players(name) VALUES(?)', title.name)
		end
		db.close
		return @player_array
	end

	def teams
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true

		print "Please name team 1: "
		team_name = gets.chomp
		db.execute('INSERT INTO teams(name) VALUES(?)', team_name)
		db.execute('UPDATE players SET team = ? WHERE rowID IS 1', team_name)
		db.execute('UPDATE players SET team = ? WHERE rowID IS 3', team_name)

		print "Please name team 2: "
		team_name = gets.chomp
		db.execute('INSERT INTO teams(name) VALUES(?)', team_name)
		db.execute('UPDATE players SET team = ? WHERE rowID IS 2', team_name)
		db.execute('UPDATE players SET team = ? WHERE rowID IS 4', team_name)
		db.close
		puts #newline
	end

	def bids(player_array)
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true

		player_array.each do |title|
			print "What is " + title.name + "'s bid? "
			input = gets.chomp
			title.bid = input
			db.execute('UPDATE players SET bid = ? WHERE name IS ?', input, title.name)
			title.bid = input
		end
		puts #newline

		db.close
	end
end #Gather

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

		return player_array
	end
end #Dealing

def set_tables 
	db = SQLite3::Database.open 'playerbase.db'
	db.results_as_hash = true
	db.execute "DROP TABLE IF EXISTS players"
	db.execute "DROP TABLE IF EXISTS teams"

	db.execute "CREATE TABLE IF NOT EXISTS players (name TEXT, bid INT, blind INT, tricks_taken INT, team TEXT, dealer INT default 0)"
	db.execute "CREATE TABLE IF NOT EXISTS teams (name TEXT, total_bid INT, tricks_taken INT, bags INT DEFAULT 0, score INT DEFAULT 0)"
	db.close
end

set_tables

player_array = Gather.new.players(4)
team_array = Gather.new.teams
order = Dealing.new()

#while score -lt 500; do
player_array = order.rotate(player_array)
Gather.new.bids(player_array)
player_array = order.rotate(player_array)
#end



#current_dealer = Round.new.new_dealer(player_array)


#player_array.each do |player|
	#Gather.new.bids(player)
#end
#player_array.each do |title|
	#puts title.bid
#end

