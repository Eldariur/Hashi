class Case
	 #@x
	 #@y

	attr:x, false
	attr:y, false


	def initialize(x, y)
		@x = x
		@y = y
	end

	def Case.creer(x,y)
		new(x,y)
	end

end
