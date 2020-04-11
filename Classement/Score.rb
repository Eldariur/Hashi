require_relative "../Classement/Highscore.rb"
require_relative "../Classement/Classement.rb"

# Cette classe represente un score.
class Score
	#@pseudo -> Le pseudo associé au score.
	#@temps -> Le temps associé au score.
	#@points -> La valeur du score.
	#@difficulte -> La difficulte liée au score.

	# Accesseur get sur l'attribut pseudo.
	attr:pseudo, false
	# Accesseur get sur l'attribut score.
	attr:points, false
	# Accesseur get sur l'attribut time.
	attr:time, false
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
		@difficulte = difficulte
	end

	# Créer un nouveau score.
	# === Parametre
	# * +nom+ : nom Le pseudo associé au highscore.
	# * +time+ : time Le temps associé au highscore.
	# * +difficulte+ : difficulte La difficulte associée au score.
	def Score.creer(nom, time, difficulte)
		new(nom, time, difficulte)
	end

	# Cette méthode demande à l'utilisateur de saisir un nom.
	def Score.askName()
		print "Veuillez saisir un nom : "
		return gets.chomp
	end

	# Cette méthode calcul le nombre de points d'un score.
	def calculScore()
		tMax = 0
		case @difficulte
			when "easy"
				tMax = 60
			when "normal"
				tMax = 90
			when "hard"
				tMax = 120
		end
		temp = (tMax / @temps) *100
		if(temp < 0) then temp = 0 end
		@points = (temp*temp)%1000000
	end

	# Cette méthode sauvegarde un score dans la base de donnees.
	def sauvegarder()
		self.calculScore()
		classementTemp =  Classement.creer(@difficulte)
		highscoreTemp = Highscore.creer()
		if classementTemp.isHighScore?(self) then highscoreTemp.sauvegarder(@pseudo, @points, @difficulte) end
	end

	# Cette méthode redefini to_s pour afficher un score.
	def to_s
		"Score : Pseudo = #{@pseudo}, Points = #{@points}, Temps = #{@temps}, Difficulte = #{@difficulte}\n"
	end

	# Cette méthode redefini to_i pour les scores.
	def to_i
		return @points
	end

end
