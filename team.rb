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

	def self.list_score
		@@list.each do |team|
			puts team.score
		end
	end

	def self.allow_blind?()
		if self.list.first.score >= 100 + self.list.last.score
			return self.list.first.name
		elsif self.list.last.score >= 100 + self.list.first.score
			return self.list.last.name
		else
			return nil
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

	def up_score(num)
		@score = @score + num.to_i
	end

	def down_score(num)
		@score = @score - num.to_i
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
			if player.nil?
				if player.blind?
					player.succeed? ? self.up_score(100) : self.down_score(100)
				else
					player.succeed? ? self.up_score(50) : self.down_score(50)
				end
			end
		end
	end
end
