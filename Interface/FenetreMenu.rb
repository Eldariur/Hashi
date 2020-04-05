class FenetreMenu < Gtk::Box

  def initialize(window)
    super(Gtk::Orientation::VERTICAL)
    @@fenetre = window
    @@fenPre = nil
    tbl = Gtk::Table.new(1,1)
    vBox = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    bouton1 = UnBoutonPerso.new("Jouer", "BoutonMenu")
    bouton2 = UnBoutonPerso.new("Classement", "BoutonMenu")
    bouton3 = UnBoutonPerso.new("Quitter", "BoutonMenu")

    #image = Gtk::Image.new("img/schema_projet.JPG")
    bouton1.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreMenuJouer.new(@@fenetre))
    }

    bouton2.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreClassement.new(@@fenetre))
    }

    bouton3.signal_connect('clicked') {
      Gtk.main_quit
    }

    vBox.add(bouton1)
    vBox.add(bouton2)
    vBox.add(bouton3)
    tbl.attach(vBox,0,1,0,1, Gtk::AttachOptions::EXPAND)
    self.add(tbl)

    #@@fenetre.add(self)

  end

  def lancementFenPre
    unless @@hudPrecedent==nil
      @@fenetre.changerWidget(@@fenPre)
    end
    self
  end

end
