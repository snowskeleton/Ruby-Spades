#!/bin/ruby
require 'sqlite3'
require_relative 'player'
require_relative 'dealing'

class Team
	attr_accessor :players, :bid, :tricks, :bags, :score, :name
	@@list = []

	def initialize(array_of_players, team_name)
		@name = team_name
		@players = array_of_players
		@@list.push(self)
		@tricks = 0
		@bid = 0
	end

	def self.list
		@@list
	end

	def self.declare()
		self.list.each do |team|
			print team.list_players, + " are on team ", + team.name
			puts #newline
		end
		sleep(1)
		puts #newline
	end

	def self.set_tricks
		@@list.each do |team|
			team.set_tricks
		end
	end

	def players()
		@players
	end


	def set_bid()
		@bid = 0
		@players.each do |player|
			@bid = @bid + player.bid.to_i
		end
	end

	def set_tricks()
		@tricks = 0
		@players.each do |player|
			@tricks = @tricks + player.tricks.to_i
		end
	end

	def list_players() #only used for sending input to the screen. does not return the actual player objects
		return @players.first.name + " and " + @players.last.name
	end

	def update_score
		if @tricks >= bid
			@score = @score + ((@bid * 10) + (@tricks - @bid))
			@bags = @bags + (@tricks - @bid)
			if @bags >= 10
				@score = @score - 100
				@bags = 0
			end
		else
			@score = @score - (@bid * 10)
		end

		@players.each do |player|
			if player.bid = 0 && player.tricks = 0
				player.blind = 1 ? @score = @score + 100 : @score = @score + 50
			end
			if player.bid = 0 && player.tricks >= 0
				player.blind = 1 ? @score = @score - 100 : @score = @score - 50
	end
end

class Game
	def self.set_tables 
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute "DROP TABLE IF EXISTS players"
		db.execute "DROP TABLE IF EXISTS teams"

		db.execute "CREATE TABLE IF NOT EXISTS players (name TEXT, bid INT DEFAULT 0, blind INT DEFAULT 0, tricks INT DEFAULT 0, team TEXT, dealer INT DEFAULT 0)"
		db.execute "CREATE TABLE IF NOT EXISTS teams (name TEXT, bid INT DEFAULT 0, tricks INT DEFAULT 0, bags INT DEFAULT 0, score INT DEFAULT 0)"
		db.close
	end

	def self.persist(player_array)
		player_array.each do |player|
			player.persist
		end
	end
	
	def self.declare_bid(player_array)
		player_array.each do |player|
			print player.name, + " bid ", + player.bid, + "."
		puts #newline
		end
		puts #newline
		print "Is this correct? "
		#if not, then retry. somehow.
	end

	def score_too_high?()
	end

	def update_score 
		#Team.list.each do |
		#end
	end
end

class Gather
	def self.players(number)
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

	def self.teams(player_array) # I don't like this. Feels sloppy.
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

	def self.bids(player_array)
		player_array.each do |player|
			print "What does " + player.name + " bid? "
			bid = gets.chomp
			player.set_bid = (bid)
		end
		puts #newline
	end

	def self.tricks()
		Team.list.each do |team|
			team.players.each do |player|
				print "How many tricks did " + player.name + " take? "
				tricks = gets.chomp
				player.set_tricks = (tricks)
			end
		end
		puts #newline
	end
end

def calculate_score
team_array.each do |team|
	team.set_tricks
end

team_array.each do |team|
	team.set_bid
end
end

Game.set_tables

player_array = Gather.players(4)
team_array = Gather.teams(player_array)
Team.declare

#while score -lt 500; do
player_array = Dealing.rotate(player_array)

Gather.bids(player_array)
Game.declare_bid(player_array)

Game.persist(player_array)

Gather.tricks
Player.declare_tricks()

Team.set_tricks
