class FenetreMenuJouer < Gtk::Box

  def initialize(window)
    super(Gtk::Orientation::VERTICAL)
    @@fenetre = window
    #@@fenPre = self
    tbl = Gtk::Table.new(1,1)
    vBox = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    bouton1 = UnBoutonPerso.new("Tutoriel", "BoutonMenu")
    bouton2 = UnBoutonPerso.new("Normal", "BoutonMenu")
    bouton3 = UnBoutonPerso.new("Contre-la-montre", "BoutonMenu")

    bouton1.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreTuto.new(@@fenetre))
    }

    bouton2.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreModesDifficultes.new(@@fenetre))
    }

    bouton3.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreModeChrono.new(@@fenetre))
    }

    vBox.add(bouton1)
    vBox.add(bouton2)
    vBox.add(bouton3)
    tbl.attach(vBox,0,1,0,1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0, @@fenetre.default_size[1] / 3)
    self.add(tbl)

    self.show_all

  end

end
