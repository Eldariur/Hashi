require "active_record"

# Cette classe represente un score.
class Highscore < ActiveRecord::Base

  # Creer un nouveau score.
	 def Highscore.creer()
		 new()
	 end

	#Privatise le new.
	private_class_method :new

	# Initialisation de la class Score.
	# === Parametre
	# * +b+ : b Utilisé pour ActiveRecord.
	def initialize(b)
		super(:name => "", :score => 0)
	end

	# Cette methode sauvegarde un score dans la base de donnees.
	def sauvegarder(pseudo, points)
		self.name = pseudo
		self.score = points
		return self.save()
	end

	# Cette methode redefini to_s pour afficher un score.
	def to_s
		"Highscore : Pseudo = #{self.name}, Points = #{self.score}\n"
	end
end
