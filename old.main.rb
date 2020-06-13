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

team_array.each do |team|
	team.update_score
end

Team.list_score
end
