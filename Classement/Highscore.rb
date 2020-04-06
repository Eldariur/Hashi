require "active_record"

# Cette classe represente un highscore.
class Highscore < ActiveRecord::Base

  # Creer un nouveau highscore.
	 def Highscore.creer()
		 new()
	 end

	#Privatise le new.
	private_class_method :new

	# Initialisation de la classe Highscore.
	# === Parametre
	# * +b+ : b Utilisé pour ActiveRecord.
	def initialize(b)
		super(:name => "", :score => 0, :difficulty => "")
	end

	# Cette methode sauvegarde un highscore dans la base de données.
	# === Parametre
	# * +pseudo+ : pseudo Le pseudo associé au highscore.
	# * +points+ : points Les points associés au highscore.
	def sauvegarder(pseudo, points, difficulte)
		self.name = pseudo
		self.score = points
		self.difficulty = difficulte
		return self.save()
	end

	# Cette methode retourne le nom d'un highscore.
	# === Return
	# * +self.name.to_s+ : self.name.to_s Le pseudo associé au highscore.
	def getNom()
		return self.name.to_s
	end

	# Cette methode retourne le score d'un highscore.
	# === Return
	# * +self.score.to_s+ : self.score.to_s Le score associé au highscore.
	def getScore()
		return self.score.to_s
	end

	# Cette methode redefini to_s pour afficher un highscore.
	def to_s
		"Highscore : Pseudo = #{self.name}, Points = #{self.score}, Difficulte = #{self.difficulty}\n"
	end
end
