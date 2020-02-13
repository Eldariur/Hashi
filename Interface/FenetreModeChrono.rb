class FenetreModeChrono < Gtk::Box

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    bouton1 = UnBoutonPerso.new("Facile")
    bouton2 = UnBoutonPerso.new("Normal")
    bouton3 = UnBoutonPerso.new("Difficile")


    self.add(bouton1)
    self.add(bouton2)
    self.add(bouton3)

  end

end
