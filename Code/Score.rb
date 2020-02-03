class Score
	 #@pseudo
	 #@points
   #@malus
   #@time

	attr:pseudo, false
	attr:points, false
  attr:malus, false
	attr:time, false


	def initialize(pseudo, pts, pen, t)
		@pseudo = pseudo
		@points = pts
    @malus = pen
    @time = t
	end

	def Score.creer(pseudo,points,malus,temps)
		new(pseudo,points,malus,temps)
	end

end
