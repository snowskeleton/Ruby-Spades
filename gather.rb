#!/bin/ruby

class Gather
	def self.players(number)
		num = 1

		number.times {
			print "Who is player " + num.to_s + "? "
			player = gets.chomp.to_s
			player = Player.new(player)
			num += 1
		}
		puts #newline
	end

	def self.teams() # I don't like this. Feels sloppy.
		print "Please name team 1: "
		team_name = gets.chomp.to_s
		team = []
		team.push(Player.list[0])
		team.push(Player.list[2])
		team.each do |player|
			player.set_team = (team_name)
		end
		team_one = Team.new(team, team_name)

		print "Please name team 2: "
		team_name = gets.chomp.to_s
		team = []
		team.push(Player.list[1])
		team.push(Player.list[3])
		team.each do |player|
			player.set_team = (team_name)
		end
		team_two = Team.new(team, team_name)
		puts #newline

	end

	def self.bids()
		Player.list.each do |player|
			print "What does " + player.name + " bid? "
			bid = Game.input_digit()

			player.set_bid = (bid)

			if bid == 0 && Team.allow_blind?(player)
				print "Is ", + player.name, + " blind? "
				answer = gets.chomp.to_s
				case answer
				when  'yes', 'y', 'ye', 'yse', 'esy', 'eys'
					player.set_blind=(1)
					puts "You're dark company.\n"
				else
					puts "May the light of your soul guide you.\n"
					player.set_blind=(0)
				end
			end
		end
		puts #newline
		Team.declare_bid
	end

	def self.tricks()
		total_tricks = 0
		Team.list.each do |team|
			team.players.each do |player|
				print "How many tricks did " + player.name + " take? "
				tricks = gets.to_i
				player.set_tricks = (tricks)
				total_tricks += tricks
			end
		end
		#comment once you want to test
		if total_tricks != 13
			puts "\nSomeone messed up here. Please try again."
			sleep(1)
			puts
			self.tricks
		end
		puts #newline
	end
end
