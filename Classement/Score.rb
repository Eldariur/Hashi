class Score
	 #@pseudo
	 #@points
   #@malus
   #@time

	attr:pseudo, false
	attr:time, false
	attr:score, false
  attr:malus, false

	def initialize(p, s, t, m)
		@pseudo = p
		@score = s
    @malus = m
    @time = t
	end

	def Score.creer(p, s, t, m)
		new(p, s, t, m)
	end

	def setName(pseudo)
		@pseudo = pseudo
	end

	def setTime(time)
		@time = time
	end

	def addMalus(val)
		@malus += val
	end

	def calculScore(tMax)
		temp = @time.to_i + @malus.to_i
		#tMax = 100
		if(temp > tMax) then
			@score = 0
		else @score = 1000000-((1000000/tMax)*(tMax-(temp+tMax))*((tMax-(temp+tMax))/tMax)) end
	end

	def to_s
		"Score : Pseudo = #{@pseudo}, Score = #{@score}, Temps = #{@time}, Malus = #{@malus}\n"
	end


end
