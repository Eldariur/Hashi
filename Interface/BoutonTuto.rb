# classe représentant un Bouton du tutoriel
class BoutonTuto < Gtk::Button

  ## Partie variables d'instance

  # @@fenetre -> la fenêtre principale du programme

  ## Partie initialize

	# Initialisation de la classe BoutonTuto
	#
	# === Paramètres
	#
	# * +window+ : window la fenêtre principale du programme
	# * +fenPre+ : fenPre la fenêtre précédente
  # * +str+ : str la chaîne de carcatère affichée sur le bouton
  # * +niveau+ : niveau le nom du niveau du tutoriel
  # * +labelNom+ : labelNom la classe du label du bouton
  def initialize(window, fenPre, str="", niveau = nil, labelNom="UnLabelPerso")
		super()


    @@fenetre = window
    self.add(UnLabelPerso.new(str))
    self.set_name("BoutonTuto")
    tuto = Tutoriel.nouveau(niveau)

		signal_connect("clicked") {
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre,fenPre,'easy', false, nil, nil, nil, nil, tuto))
		}
  end

end
