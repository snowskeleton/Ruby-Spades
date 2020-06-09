#!/bin/ruby
require 'sqlite3'

class Player
	attr_accessor :name, :bid, :blind, :tricks

	def initialize(name)
		@name = name
		@bid = 0
		@tricks = 0

		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('INSERT INTO players(name) VALUES(?)', @name)
		db.close
	end

	def persist()
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('UPDATE players SET bid = ?, blind = ?, tricks = ? WHERE name IS ?', @bid, @blind, @tricks, @name)
		db.close
	end

	def set_team=(team)
		@team = team
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('UPDATE players set team = ? WHERE name IS ?', @team, @name)
		db.close
	end

	def set_bid=(bid)
		@bid = bid
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('UPDATE players SET bid = ? WHERE name IS ?', @bid)
		db.close
	end
end

class Team
	attr_accessor :players, :bid, :tricks, :bags, :score, :name

	def initialize(array_of_players, team_name)
		@name = team_name
		@players = array_of_players
	end

	def list_players()
		return @players.first.name + " and " + @players.last.name

		#@players.each do |player|
			#puts player.name
		#end
		#return nil
	end
end

class Game
	def set_tables 
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute "DROP TABLE IF EXISTS players"
		db.execute "DROP TABLE IF EXISTS teams"

		db.execute "CREATE TABLE IF NOT EXISTS players (name TEXT, bid INT DEFAULT 0, blind INT DEFAULT 0, tricks INT DEFAULT 0, team TEXT, dealer INT DEFAULT 0)"
		db.execute "CREATE TABLE IF NOT EXISTS teams (name TEXT, bid INT DEFAULT 0, tricks INT DEFAULT 0, bags INT DEFAULT 0, score INT DEFAULT 0)"
		db.close
	end

end

class Gather
	def players(number)
		@player_array = []
		num = 1

		number.times {
			print "Who is player " + num.to_s + "? "
			player = gets.chomp.to_s
			player = Player.new(player)
			@player_array.push(player)
			num += 1
		}
		puts #newline
		return @player_array
	end

	def teams(player_array) # I don't like this. Feels sloppy.
		team_array = []
		print "Please name team 1: "
		team_name = gets.chomp
		team = []
		team.push(player_array[0])
		team.push(player_array[2])
		team.each do |player|
			player.set_team = (team_name)
		end
		team_one = Team.new(team, team_name)
		team_array.push(team_one)

		print "Please name team 2: "
		team_name = gets.chomp
		team = []
		team.push(player_array[1])
		team.push(player_array[3])
		team.each do |player|
			player.set_team = (team_name)
		end
		team_two = Team.new(team, team_name)
		team_array.push(team_two)
		puts #newline
		return team_array
	end

	def bids(player_array)
		player_array.each do |player|
			print "What does " + player.name + " bid? "
			input = gets.chomp
			player.bid = (input)
		end
		puts #newline
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
		puts #newline

		return player_array
	end
end #Dealing


arbiter = Game.new
arbiter.set_tables

gatherer = Gather.new
player_array = gatherer.players(4)
team_array = gatherer.teams(player_array)
order = Dealing.new()

team_array.each do |team|
	print team.list_players, + " are on team ", + team.name
	puts #newline
end
puts #newline

#while score -lt 500; do
player_array = order.rotate(player_array)
gatherer.bids(player_array)
player_array = order.rotate(player_array)
player_array.each do |player|
	player.persist
end

