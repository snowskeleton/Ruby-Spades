#!/bin/ruby
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

		print "Is this correct? "
		answer = gets.chomp
		case answer
		when "no", "n", "on", "ono"
			self.declare_bid(player_array)
		else
			next
		end
	end

	def self.allow_blind?(player)
		team = Team.which_team_player(player)
		Team.allow_blind?(team) ? true : false
	end

	def self.keep_going?()
		if (Team.list.first.score >= 500 || Team.list.last.score >= 500) && (Team.list.first.score != Team.list.last.score)
			return false
		else
			return true
		end
	end
end
