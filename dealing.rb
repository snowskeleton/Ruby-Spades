#!/bin/ruby
class Dealing
	@@start = true

	def self.rotate()


		if @@start == false then
			Player.list.rotate!(1)
			print Player.list.last.name, + " is dealing next."
		else
			@@start = false
			dealer_count = rand(1..4)
			Player.list.rotate!(dealer_count)
			print Player.list.last.name, + " is dealing first."
		end

		sleep(1)
		puts #newline
		puts #newline
	end
end
