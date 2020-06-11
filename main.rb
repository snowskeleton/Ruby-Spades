#!/bin/ruby
require 'sqlite3'
require_relative 'player'
require_relative 'dealing'
require_relative 'team'
require_relative 'gather'

class Game
	@@continue = true

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
		#print "Is this correct? "
		#if not, then retry. somehow.
	end

	def self.keep_going?()
		if (Team.list.first.score >= 500 || Team.list.last.score >= 500) && (Team.list.first.score != Team.list.last.score)
			return false
		else
			return true
		end
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

while Game.keep_going?
player_array = Dealing.rotate(player_array)

Gather.bids(player_array)
Game.declare_bid(player_array)

Game.persist(player_array)

Gather.tricks
Player.declare_tricks() #this should probably be from Team, not Player

Team.set_tricks
Team.set_bid

#Team.update_score
team_array.each do |team|
	team.update_score
end
Team.list_score
end
