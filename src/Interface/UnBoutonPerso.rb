#Class UnBoutonPerso, permet de modifier les boutons et de leurs ajouter des méthodes, hérite de la classe Gtk::Button
class UnBoutonPerso < Gtk::Button
	@Override
	##Partie initialize
	#Initialisation de la classe UnBoutonPerso
	#
	# === Paramètres
	#
	# * +str+ : Défini le message à afficher sur le bouton.
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

	#Permet d'empêcher l'utilisateur de cliquer sur le bouton.
	def verrouiller()
		self.set_sensitive(false)
	end

	#Permet d'autoriser l'utilisateur de cliquer sur le bouton.
	def deverrouiller()
		self.set_sensitive(true)
	end

end
