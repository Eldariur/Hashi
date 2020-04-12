# Classe permettant d'afficher la fenêtre de menu du mode Contre-la-montre
class FenetreModeChrono < Gtk::Box
  ## Partie variables d'instance

  # @@fenetre -> la fenêtre principale du programme
  # @classe -> booléen indiquant quand la fenêtre de jeu est en mode Contre-la-montre


  ## Partie initialize

  # Initialisation de la classe FenetreClassement
  #
  # === Paramètres
  #
  # * +window+ : window la fenetre principale du programme
  # * +fenetrePre+ : fenetrePre la fenêtre précédente
  def initialize(window,fenetrePre)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    @classe = true

    tbl = Gtk::Table.new(1,1)
    vBox = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    bouton1 = UnBoutonPerso.new("Facile", "BoutonMenu")
    bouton2 = UnBoutonPerso.new("Normal", "BoutonMenu")
    bouton3 = UnBoutonPerso.new("Difficile", "BoutonMenu")
	boutonRetour = UnBoutonPerso.new("Retour","BoutonMenu")
    bouton1.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre,self, "easy", @classe))
    }

    bouton2.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre,self, "normal", @classe))
    }

    bouton3.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre,self, "hard", @classe))
    }

	boutonRetour.signal_connect('clicked'){
	@@fenetre.changerWidget(fenetrePre)
    }

    vBox.add(bouton1)
    vBox.add(bouton2)
    vBox.add(bouton3)
	vBox.add(boutonRetour)
    tbl.attach(vBox,0,1,0,1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0, @@fenetre.default_size[1] / 3)
    self.add(tbl)

    self.show_all

  end
end
