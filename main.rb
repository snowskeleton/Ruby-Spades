#!/bin/ruby
require 'sqlite3'
require_relative 'player'
require_relative 'dealing'

class Team
	attr_accessor :players, :bid, :tricks, :bags, :score, :name

	def initialize(array_of_players, team_name)
		@name = team_name
		@players = array_of_players
	end

	def list_players() #only used for sending input to the screen. does not return the actual player objects
		return @players.first.name + " and " + @players.last.name
	end
	def players()
		@players
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
			bid = gets.chomp
			player.set_bid = (bid)
		end
		puts #newline
	end

	def tricks(team_array)
		team_array.each do |team|
			team.players.each do |player|
				print "How many tricks did " + player.name + " take? "
				tricks = gets.chomp
				player.set_tricks = (tricks)
			end
		end
		puts #newline
	end
end #Gather

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
gatherer.tricks(team_array)

player_array.each do |player|
	puts player.bid
end
