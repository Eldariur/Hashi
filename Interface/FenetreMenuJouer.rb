class FenetreMenuJouer < Gtk::Box

  def initialize(window)
    super(Gtk::Orientation::VERTICAL)
    @@fenetre = window
    #@@fenPre = self
    bouton1 = UnBoutonPerso.new("Tutoriel")
    bouton2 = UnBoutonPerso.new("Normal")
    bouton3 = UnBoutonPerso.new("Contre-la-montre")


    bouton2.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreModesDifficultes.new(@@fenetre))
    }

    bouton3.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreModeChrono.new(@@fenetre))
    }

    self.add(bouton1)
    self.add(bouton2)
    self.add(bouton3)

    self.show_all

  end

end
