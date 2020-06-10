#!/bin/ruby
class Player
	attr_accessor :name, :bid, :blind, :tricks

	def initialize(name)
		@name = name
		@bid = 0
		@tricks = 0

		db = SQLite3::Database.open 'playerbase.db'
		db.results_as_hash = true
		db.execute('INSERT INTO players(name) VALUES(?)', @name)
		db.close
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
end
