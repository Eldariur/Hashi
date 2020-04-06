class FenetreMenuJouer < Gtk::Box

  def initialize(window)
    super(Gtk::Orientation::VERTICAL)
    @@fenetre = window
    #@@fenPre = self
    tbl = Gtk::Table.new(5,5, true)
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
    tbl.attach(vBox,2,3,2,3)
    self.add(tbl)

    self.show_all

  end

end
