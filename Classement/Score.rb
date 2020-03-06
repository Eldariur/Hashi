require "active_record"

# Cette classe represente un score.
class Score < ActiveRecord::Base
	 #@pseudo -> Le pseudo associé au score.
	 #@time -> Le temps associé au score.
   #@score -> La valeur du score.
   #@malus -> Le malus en secondes du score.

  # Creer un nouveau score.
	 def Score.creer()
		 new()
	 end

 	# Accesseur get sur l'attribut pseudo.
	attr:pseudo, false
	# Accesseur get sur l'attribut score.
	attr:score, false
	# Accesseur get sur l'attribut time.
	attr:time, false
	# Accesseur get sur l'attribut malus.
  attr:malus, false

	#Privatise le new.
	private_class_method :new

	# Initialisation de la class Score.
	# === Parametre
	# * +b+ : b Utilisé pour ActiveRecord.
	def initialize(b)
		super(:name => "", :points => 0)
		@pseudo = nil
		@score = 0
    @malus = 0
    @time = 0
	end

	# Cette methode demande à l'utilisateur de saisir un nom.
	def setName()
		print "Veuillez saisir un nom : "
		@pseudo = gets.chomp
	end

	# Cette methode change le temps dans un score.
	# === Parametre
	# * +time+ : time La nouvelle valeur de temps.
	def setTime(time)
		@time = time
	end

	# Cette methode ajoute du malus dans un score.
	# === Parametre
	# * +val+ : val La valeur de malus.
	def addMalus(val)
		@malus += val
	end

	# Cette methode calcul un score.
	# === Parametre
	# * +tMax+ : tMax La valeur en secondes maximal pour resoudre un puzzle.
	def calculScore(tMax)
		temp = @time.to_i + @malus.to_i
		if(temp > tMax) then
			@score = 0
		else @score = 1000000-((1000000/tMax)*(tMax-(temp+tMax))*((tMax-(temp+tMax))/tMax)) end
	end

	# Cette methode sauvegarde un score dans la base de donnees.
	def sauvegarder()
		self.name = @pseudo
		self.points = @score
		return self.save()
	end

	# Cette methode redefini to_s pour afficher un score.
	def to_s
		"Score : Pseudo = #{@pseudo}, Points = #{@score}, Temps = #{@time}, Malus = #{@malus}\n"
	end

end
