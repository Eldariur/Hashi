class FenetreModesDifficultes < Gtk::Box

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    bouton1 = UnBoutonPerso.new("Facile")
    bouton2 = UnBoutonPerso.new("Normal")
    bouton3 = UnBoutonPerso.new("Difficile")
    bouton4 = UnBoutonPerso.new("Custom")

    bouton4.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreParametres.new(@@fenetre))
    }


    self.add(bouton1)
    self.add(bouton2)
    self.add(bouton3)
    self.add(bouton4)

  end

end
