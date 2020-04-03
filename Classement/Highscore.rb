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
		super(:name => "", :score => 0)
	end

	# Cette methode sauvegarde un highscore dans la base de données.
	# === Parametre
	# * +pseudo+ : pseudo Le pseudo associé au highscore.
	# * +points+ : points Les points associés au highscore.
	def sauvegarder(pseudo, points)
		self.name = pseudo
		self.score = points
		return self.save()
	end

	# Cette methode redefini to_s pour afficher un highscore.
	def to_s
		"Highscore : Pseudo = #{self.name}, Points = #{self.score}\n"
	end
end
