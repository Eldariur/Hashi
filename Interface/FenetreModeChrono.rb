class FenetreModeChrono < Gtk::Box

  #@classe

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    @classe = true

    tbl = Gtk::Table.new(1,1)
    vBox = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    bouton1 = UnBoutonPerso.new("Facile", "BoutonMenu")
    bouton2 = UnBoutonPerso.new("Normal", "BoutonMenu")
    bouton3 = UnBoutonPerso.new("Difficile", "BoutonMenu")

    bouton1.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, "easy", @classe))
    }

    bouton2.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, "normal", @classe))
    }

    bouton3.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, "hard", @classe))
    }

    vBox.add(bouton1)
    vBox.add(bouton2)
    vBox.add(bouton3)
    tbl.attach(vBox,0,1,0,1, Gtk::AttachOptions::EXPAND)
    self.add(tbl)

    self.show_all

  end
end
