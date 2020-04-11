require "active_record"

# Cette classe represente un highscore.
class Highscore < ActiveRecord::Base

	#Privatise le new.
	private_class_method :new

	# Initialisation de la classe Highscore.
	# === Parametre
	# * +temp+ : temp Utilisé pour ActiveRecord.
	def initialize(temp)
		super(:name => "", :score => 0, :difficulty => "")
	end

  # Créer un nouveau highscore.
	def Highscore.creer()
		new()
	end

	# Cette méthode sauvegarde un highscore dans la base de données.
	# === Parametre
	# * +pseudo+ : pseudo Le pseudo associé au highscore.
	# * +points+ : points Les points associés au highscore.
	# * +difficulte+ : difficulte La difficulté associée au highscore.
	def sauvegarder(pseudo, points, difficulte)
		self.name = pseudo
		self.score = points
		self.difficulty = difficulte
		return self.save()
	end

	# Cette méthode retourne le nom d'un highscore.
	# === Return
	# * +self.name.to_s+ : self.name.to_s Le pseudo associé au highscore.
	def getNom()
		return self.name.to_s
	end

	# Cette méthode retourne le score d'un highscore.
	# === Return
	# * +self.score.to_s+ : self.score.to_s Le score associé au highscore.
	def getScore()
		return self.score.to_s
	end

	# Cette méthode redefini to_s pour afficher un highscore.
	def to_s
		"Highscore : Pseudo = #{self.name}, Points = #{self.score}, Difficulte = #{self.difficulty}\n"
	end
end
