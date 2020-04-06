require "active_record"
require_relative "./Highscore.rb"

# Cette classe represente un score.
class Score
	 #@pseudo -> Le pseudo associé au score.
	 #@temps -> Le temps associé au score.
   #@points -> La valeur du score.
   #@malus -> Le malus en secondes du score.
	 #@difficulte -> La difficulte liée au score.

  # Creer un nouveau score.
	# === Parametre
	# * +nom+ : nom Le pseudo associé au highscore.
	# * +time+ : time Le temps associé au highscore.
	# * +difficulte+ : difficulte La difficulte associée au score.
	 def Score.creer(nom, time, difficulte)
		 new(nom, time, difficulte)
	 end

 	# Accesseur get sur l'attribut pseudo.
	attr:pseudo, false
	# Accesseur get sur l'attribut score.
	attr:points, false
	# Accesseur get sur l'attribut time.
	attr:time, false
	# Accesseur get sur l'attribut malus.
  attr:malus, false
	# Accesseur get sur l'attribut difficulte.
	attr:difficulte, false


	#Privatise le new.
	private_class_method :new

	# Initialisation de la class Score.
	# === Parametre
	# * +nom+ : nom Le pseudo associé au highscore.
	# * +time+ : time Le temps associé au highscore.
	# * +difficulte+ : difficulte La difficulte associée au score.
	def initialize(nom, time, difficulte)
		@pseudo = nom
		@points = 0
		@temps = time
    @malus = 0
		@difficulte = difficulte
	end

	# Cette methode demande à l'utilisateur de saisir un nom.
	def Score.askName()
		print "Veuillez saisir un nom : "
		return gets.chomp
	end

	# Cette methode ajoute du malus dans un score.
	# === Parametre
	# * +val+ : val La valeur de malus.
	def addMalus(val)
		@malus += val
	end

	# Cette methode calcul un score.
	# === Parametre
	# * +tMax+ : tMax La valeur en secondes maximal pour résoudre un puzzle.
	def calculScore(tMax)
		temp = @time.to_i + @malus.to_i
		if(temp > tMax) then
			@points = 0
		else @points = 1000000-((1000000/tMax)*(tMax-(temp+tMax))*((tMax-(temp+tMax))/tMax)) end
	end

	# Cette methode sauvegarde un score dans la base de donnees.
	def sauvegarder()
		temp = Highscore.creer()
		temp.sauvegarder(@pseudo, @points, @difficulte)
	end

	# Cette methode redefini to_s pour afficher un score.
	def to_s
		"Score : Pseudo = #{@pseudo}, Points = #{@points}, Temps = #{@temps}, Malus = #{@malus}, Difficulte = #{@difficulte}\n"
	end

	# Cette methode redefini to_i pour les scores.
	def to_i
		return @points
	end

end
