#Class UnBoutonPerso, permet de modifier les boutons et de leur ajouter des méthodes, herite de la classe Gtk::Button
class UnBoutonPerso < Gtk::Button
	@Override
	##Partie initialize
	#Initialisation de la classe UnBoutonPerso
	#
	# === Paramètres
	# 
	# * +str+ : Défini le message à afficher sûr le bouton.
	# * +nom+ : Défini un nom au bouton pour le css
	# * +labelNom+ : Défini un label en plus. 
  def initialize(str="", nom="UnBoutonPerso", labelNom="UnLabelPerso")
		super()

    self.add(UnLabelPerso.new(str))
    self.set_name(nom)

	if block_given?
		signal_connect("clicked") {
			yield
		}
	end
  end
	
	# Partie méthodes

	#Permet d'empecher l'utilisateur de cliquer sûr le bouton.
	def verrouiller()
		self.set_sensitive(false)
	end

	#Permet d'autoriser l'utilisateur de cliquer sûr le bouton.
	def deverrouiller()
		self.set_sensitive(true)
	end

end
