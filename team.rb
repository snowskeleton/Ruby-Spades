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

	def self.list()
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
	
	def self.declare_bid()
		Player.list.each do |player|
			print player.name, + " bid ", + player.bid, + "."
		puts #newline
		end
		puts #newline

		total_bid = 0
		Team.list.each do |team|
			print team.name, + " bid ", + team.bid, + "."
			total_bid += team.bid
		puts #newline
		end
		print "The total bid is ", + total_bid.to_s, + ".\n"
		
		puts #newline

		answer = Game.entry_validation()
		case answer
		when "no", "n", "on", "ono"
			Gather.bids()
		else
			puts #newline
		end
	end

	def self.declare_tricks()
		Player.list.each do |player|
			print player.name, + " won ", + player.tricks, + " tricks."
			puts #newline
		end
		puts #newline

		Team.list.each do |team|
			print team.name, + " won ", + team.tricks, + " tricks."
			puts #newline
		end
	end

	def self.which_team(player)
		@@list.each do |team|
			if team.players.include?(player)
				return team
			end
		end
	end

	def self.set_tricks()
		@@list.each do |team|
			team.set_tricks
		end
	end

	def self.set_bid()
		@@list.each do |team|
			team.set_bid
		end
	end

	def self.update_score()
		@@list.each do |team|
			team.update_score
		end
	end

	def self.list_score()
		@@list.each do |team|
			print team.name, + " is at ", + team.score, + ".\n"
		end
	end

	def self.allow_blind?(player)
		#this is messy. This method compares the first team to see if they're 100 points lower than the second team, if yes add to array.
		##Then it compares the second team to the first with the same rule, if yes add to array.
		##Finally, it checks if the given argument is in that array, if yes true, else false.
		team = Team.which_team(player)

		random_array = []
		if @@list.first.score <= @@list.last.score - 100
			random_array.push(@@list.first)
		end
		if @@list.last.score <= @@list.first.score - 100
			random_array.push(@@list.last)
		end
		random_array.include?(team) ? true : false
	end

	def players()
		@players
	end

	def score()
		@score
	end

	def set_bid()
		@bid = 0
		@players.each do |player|
			#puts player.name, + player.bid
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
				#@score = @score.to_i - 100
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

	def persist()
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('UPDATE teams SET bid = ?, tricks = ? WHERE name IS ?', @bid, @tricks, @name)
		db.close
	end
end
