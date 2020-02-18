require "active_record"

class Score < ActiveRecord::Base
	 #@pseudo
	 #@time
   #@score
   #@malus

	attr:pseudo, false
	attr:scoreTotal, false
	attr:time, false
  attr:malus, false

	#Privatise le new
	private_class_method :new

	def Score.creer()
		new()
	end

	def initialize(b)
		super(:name => "", :points => 0)
		@pseudo = nil
		@score = 0
    @malus = 0
    @time = 0
	end

	def setName()
		print "Veuillez saisir un nom : "
		@pseudo = gets.chomp
	end

	def setTime(time)
		@time = time
	end

	def addMalus(val)
		@malus += val
	end

	def calculScore(tMax)
		temp = @time.to_i + @malus.to_i
		if(temp > tMax) then
			@score = 0
		else @score = 1000000-((1000000/tMax)*(tMax-(temp+tMax))*((tMax-(temp+tMax))/tMax)) end
	end

	def to_s
		"Score : Pseudo = #{@pseudo}, Points = #{@score}, Temps = #{@time}, Malus = #{@malus}\n"
	end

	def sauvegarder()
		self.name = @pseudo
		self.points = @score
		return self.save()
	end


end
