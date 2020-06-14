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

	def self.input_digit()
		input = ""
		while input.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil 
			input = gets.chomp
	end

	def self.entry_validation()
		answer = ""
		while answer == ""
			print "Is this correct? "
			answer = gets.chomp.to_s
		end
		return answer
	end
	def self.persist()
		Player.list.each do |player|
			player.persist
		end
		Team.list.each do |team|
			team.persist
		end
	end

	def self.keep_going?()
		if (Team.list.first.score >= 500 || Team.list.last.score >= 500) && (Team.list.first.score != Team.list.last.score)
			return false
		else
			return true
		end
	end
end
