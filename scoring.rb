#!/bin/ruby

require 'sqlite3'

class Details

	def initialize(name)
		@final_score = 500
		@dealer_count = 0
		@player_count = 4
		@drop = true
		@gather = true
		@name = name
	end


	def print(name)
		puts @name
		puts @final_score
		puts @dealer_count
		puts @player_count
		puts @drop
		puts @gather
	end

end

#class Data

#	def initialize()
		#db = SQLite3::Database.open 'playerbase.db'
		#db.results_as_hash = true
#	end
#end

#db.execute "DROP TABLE IF EXISTS players"
#db.execute "DROP TABLE IF EXISTS teams"
#db.close
#db.execute "CREATE TABLE IF NOT EXISTS players (name TEXT, bid INT, blind INT, tricks_taken INT, team TEXT, dealer INT default 0)"
#db.execute "CREATE TABLE IF NOT EXISTS teams (name TEXT, total_bid INT, tricks_taken INT, bags INT DEFAULT 0, score INT DEFAULT 0)"
#db.execute "INSERT INTO players (name) VALUES(?)", 'isaac'
#db.close

Details.new.print(Isaac)
