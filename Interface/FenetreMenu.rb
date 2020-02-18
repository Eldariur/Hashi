class FenetreMenu < Gtk::Box

  def initialize(window)
    super(Gtk::Orientation::VERTICAL)
    @@fenetre = window
    @@fenPre = nil
    bouton1 = UnBoutonPerso.new("Jouer")
    bouton2 = UnBoutonPerso.new("Classement")
    bouton3 = UnBoutonPerso.new("Quitter")
    bouton4 = UnBoutonPerso.new("/!\\Tester les fenetres")

    #image = Gtk::Image.new("img/schema_projet.JPG")
    bouton1.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreMenuJouer.new(@@fenetre))
    }
    #vBox = Gtk::Box.new(Gtk::Orientation::VERTICAL)

    bouton2.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreClassement.new(@@fenetre))
    }

    bouton3.signal_connect('clicked') {
      Gtk.main_quit
    }

    bouton4.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreTest.new(@@fenetre))
    }


    self.add(bouton1)
    self.add(bouton2)
    self.add(bouton3)
    self.add(bouton4)

    # self.add(vBox)

    #@@fenetre.add(self)
  end

  def lancementFenPre
    unless @@hudPrecedent==nil
      @@fenetre.changerWidget(@@fenPre)
    end
    self
  end

end
