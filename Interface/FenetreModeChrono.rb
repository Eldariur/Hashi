class FenetreModeChrono < Gtk::Box

  #@classe

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    @classe = true

    bouton1 = UnBoutonPerso.new("Facile")
    bouton2 = UnBoutonPerso.new("Normal")
    bouton3 = UnBoutonPerso.new("Difficile")

    bouton1.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, "easy", @classe))
    }

    bouton2.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, "normal", @classe))
    }

    bouton3.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, "hard", @classe))
    }

    self.add(bouton1)
    self.add(bouton2)
    self.add(bouton3)

    self.show_all

  end
end
