#!/bin/ruby

require 'sqlite3'

	attr_accessor = :name, :bid, :tricks, :team, :blind
class Player
 def initialize(name)
  @name = name
 end
 def name
  @name
 end
end

class Gather
	def player_list(number)
		@player_list = []
		number.times {
		player  = gets.chomp
		player = Player.new(player)
		@player_list.push(player)
		}

		@player_list.each do |name|
			pp name
		end
	end
end


#db = SQLite3::Database.open 'playerbase.db'
#db.results_as_hash = true
#db.execute "DROP TABLE IF EXISTS players"
#db.execute "DROP TABLE IF EXISTS teams"
#db.close
#db.execute "CREATE TABLE IF NOT EXISTS players (name TEXT, bid INT, blind INT, tricks_taken INT, team TEXT, dealer INT default 0)"
#db.execute "CREATE TABLE IF NOT EXISTS teams (name TEXT, total_bid INT, tricks_taken INT, bags INT DEFAULT 0, score INT DEFAULT 0)"
#db.execute "INSERT INTO players (name) VALUES(?)", 'isaac'
#db.close

Gather.new.player_list(4)

#var  = gets.chomp
#isaac = Player.new(var)
#print isaac.name, +  " is cool\n"





#class Data

#	def initialize()
		#db = SQLite3::Database.open 'playerbase.db'
		#db.results_as_hash = true
#	end
#end
