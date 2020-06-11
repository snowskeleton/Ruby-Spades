#!/bin/ruby

class Team
	attr_accessor :players, :bid, :tricks, :bags, :score, :name
	@@list = []

	def initialize(array_of_players, team_name)
		@name = team_name
		@players = array_of_players
		@@list.push(self)
		@tricks = 0
		@bid = 0
		@score = 0
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

	def self.set_bid
		@@list.each do |team|
			team.set_bid
		end
	end

	def self.update_score
		@@list.each do |team|
			team.update_score
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

	def update_score()
		if @tricks >= bid
			@score = @score.to_i + ((@bid.to_i * 10) + (@tricks.to_i - @bid.to_i))
			@bags = @bags.to_i + (@tricks.to_i - @bid.to_i)
			if @bags.to_i >= 10
				@score = @score.to_i - 100
				@bags = 0
			end
		else
			@score = @score.to_i - (@bid.to_i * 10)
		end

		@players.each do |player|
			if player.bid = 0 && player.tricks = 0
				player.blind == 1 ? @score = @score.to_i + 100 : @score = @score.to_i + 50
			end
			if player.bid = 0 && player.tricks >= 0
				player.blind == 1 ? @score = @score.to_i - 100 : @score = @score.to_i - 50
			end
		end
	end
end
