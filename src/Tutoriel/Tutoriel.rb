
# Cette classe représente un tutoriel.
class Tutoriel
	#@niveau -> Représente le numéro du tutoriel.
	#@txtTuto -> Contient le texte associé au tutoriel.

	attr_reader :txtTuto, :niveau

	# Privatise le new.
	private_class_method :new

	# Initialisation de la classe Tutoriel.
	# === Paramètres
	# * +numeroNiveau+ : numeroNiveau Le numéro du niveau.
	def initialize(numeroNiveau)
		@niveau = numeroNiveau
		@txtTuto = nil
	end

  # Créer un nouveau tutoriel.
	# === Paramètres
	# * +numeroNiveau+ : numeroNiveau Le numéro du niveau.
	def Tutoriel.nouveau(numeroNiveau)
		new(numeroNiveau)
	end

	# Cette méthode retourne le texte associé à un tutoriel.
	# === Return
	# * +x+ : x Le texte du tutoriel.
	def getMessageTuto()
		file_data = File.read("#{$cheminRacineHashi}/src/Tutoriel/TextTuto.txt").split("/").join(":").split(":")
		@txtTuto = file_data
		#self.set_text(@txtTuto)
		affiche = false

		file_data.each do |x|
	    	if(affiche)
				return x
			elsif( x == "\n"+@niveau.to_s)
				affiche = true
			end
		end
	end

	# Cette méthode permet de charger le fichier de sauvegarde d'un tutoriel.
	# === Return
	# * +tuto+ : tuto Le tutoriel chargé.
	def lancerTuto()
		tuto = YAML.load(File.read("#{$cheminRacineHashi}/src/Tutoriel/Niveaux/"+@niveau.to_s+".sav"))
		return tuto
	end
end
