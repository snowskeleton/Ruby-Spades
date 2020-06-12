#!/bin/ruby

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
			bid = gets.chomp.to_i
			player.set_bid = (bid)
		end
		puts #newline
	end

	def self.tricks()
		total_tricks = 0
		Team.list.each do |team|
			team.players.each do |player|
				print "How many tricks did " + player.name + " take? "
				tricks = gets.chomp.to_i
				player.set_tricks = (tricks)
				total_tricks += tricks
			end
		end
		if total_tricks > 13
			puts "\nSomeone messed up here. Please try again."
			sleep(1)
			puts
			self.tricks
		end
		puts #newline
	end
end
