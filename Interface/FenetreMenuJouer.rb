class	 FenetreMenuJouer < Gtk::Box

  def initialize(window,fenPre)
    super(Gtk::Orientation::VERTICAL)
    @@fenetre = window
    tbl = Gtk::Table.new(1,1)
    vBox = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    bouton1 = UnBoutonPerso.new("Tutoriel", "BoutonMenu")
    bouton2 = UnBoutonPerso.new("Normal", "BoutonMenu")
    bouton3 = UnBoutonPerso.new("Contre-la-montre", "BoutonMenu")
	boutonRetour = UnBoutonPerso.new("<--","BoutonMenu")
    bouton1.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreTuto.new(@@fenetre,self))
    }

    bouton2.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreModesDifficultes.new(@@fenetre,self))
    }

    bouton3.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreModeChrono.new(@@fenetre,self))
    }

	boutonRetour.signal_connect('clicked'){
		@@fenetre.changerWidget(fenPre);
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
