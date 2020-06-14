#!/bin/ruby
class Player
	attr_accessor :name, :bid, :blind, :tricks
	@@list = []

	def initialize(name)
		@name = name
		@bid = 0
		@tricks = 0
		@blind = 0
		@@list.push(self)

		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('INSERT INTO players(name) VALUES(?)', @name)
		db.close
	end

	def self.list
		@@list
	end

	def persist()
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('UPDATE players SET bid = ?, blind = ?, tricks = ? WHERE name IS ?', @bid, @blind, @tricks, @name)
		db.close
	end

	def set_team=(team)
		@team = team
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('UPDATE players set team = ? WHERE name IS ?', @team, @name)
		db.close
	end

	def team()
		@team
	end

	def set_bid=(bid)
		@bid = bid
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('UPDATE players SET bid = ? WHERE name IS ?', @bid, @name)
		db.close
	end

	def set_tricks=(tricks)
		@tricks = tricks
		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('UPDATE players SET tricks = ? WHERE name IS ?', @tricks, @name)
		db.close
	end

	def set_blind=(blind)
		@blind = blind
	end

	def self.declare_tricks()
		Player.list.each do |player|
			print player.name, + " won ", + player.tricks, + " tricks."
			puts #newline
		end
		puts #newline
		#print "Is this correct? "
		#if not, then retry. somehow.
	end

	def nil?()
		@bid == 0 ? true : false
	end

	def blind?()
		@blind.to_i == 1 ? true : false
	end

	def succeed?()
		@tricks.to_i > @bid.to_i ? false : true
	end

end
