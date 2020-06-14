#!/bin/ruby
require 'sqlite3'
require_relative 'player'
require_relative 'dealing'
require_relative 'team'
require_relative 'gather'
require_relative 'game'

def calculate_score
team_array.each do |team|
	team.set_tricks
end

team_array.each do |team|
	team.set_bid
end
end


Game.set_tables

Gather.players(4)
Gather.teams()
Team.declare()


while Game.keep_going?()
	Dealing.rotate()

	Gather.bids()
	Team.set_bid

	Game.persist()
		
	Gather.tricks
	Team.set_tricks
	Game.persist()

	Player.declare_tricks() #this should probably be from Team, not Player


	Team.update_score

	Team.list_score
end
