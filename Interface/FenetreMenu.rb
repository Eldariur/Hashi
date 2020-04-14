# Classe permettant d'afficher la fenêtre des menus du jeu lorsque l'on arrive sur le jeu
class FenetreMenu < Gtk::Box
  ## Partie variables d'instance

  # @fenetre -> la fenêtre principale du programme
  # @fenPrev -> la fenêtre précédente


  ## Partie initialize

  # Initialisation de la classe FenetreMenu
  #
  # === Paramètres
  #
  # * +window+ : window la fenêtre principale du programme
  def initialize(window)
    super(Gtk::Orientation::VERTICAL)
    @fenetre = window
    @fenPre = nil
    tbl = Gtk::Table.new(1,1)
    vBox = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    bouton1 = UnBoutonPerso.new("Jouer", "BoutonMenu")
    bouton2 = UnBoutonPerso.new("Classement", "BoutonMenu")
    bouton3 = UnBoutonPerso.new("Quitter", "BoutonMenu")

    bouton1.signal_connect('clicked') {
      @fenetre.changerWidget(FenetreMenuJouer.new(@fenetre,self))
    }

    bouton2.signal_connect('clicked') {
      @fenetre.changerWidget(FenetreClassement.new(@fenetre,self))
    }

    bouton3.signal_connect('clicked') {
      @fenetre.destroy()
      Gtk.main_quit
    }

    vBox.add(bouton1)
    vBox.add(bouton2)
    vBox.add(bouton3)
    tbl.attach(vBox,0,1,0,1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0, @fenetre.default_size[1] / 3)
    self.add(tbl)

  end
end
