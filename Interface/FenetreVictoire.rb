class FenetreVictoire < Gtk::Box

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    texteVict = UnLabelPerso.new("Félicitations, vous avez terminé cette grille en {temps} !")
    texteEnt = UnLabelPerso.new("Saisissez votre pseudonyme :")
    ent = Gtk::Entry.new()
    ent.set_placeholder_text("Votre Pseudo ici")

    bouton1 = UnBoutonPerso.new("Quitter")
    bouton2 = UnBoutonPerso.new("Valider")
    bouton3 = UnBoutonPerso.new("Rejouer")

    bouton1.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreMenu.new(@@fenetre))
    }

    self.add(texteVict)
    self.add(texteEnt)
    self.add(ent)
    self.add(bouton1)
    self.add(bouton2)
    self.add(bouton3)

  end

end
