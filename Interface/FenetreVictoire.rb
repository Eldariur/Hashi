require_relative "../Classement/Score.rb"

class FenetreVictoire < Gtk::Box

  def initialize(window,difficulte,temps="00:00")
    @@fenetre = window
    size = @@fenetre.default_size()
    super(Gtk::Orientation::VERTICAL)

    texteVict = UnLabelPerso.new("Félicitations, vous avez terminé cette grille en "+temps)
    texteEnt = UnLabelPerso.new("Saisissez votre pseudonyme :")

    fixedBoutons = Gtk::Fixed.new()

    ent = Gtk::Entry.new()
    ent.set_placeholder_text("Votre Pseudo ici")
    ent.set_size_request(200, -1)

    boutonValider = UnBoutonPerso.new("Valider")
    boutonRejouer = UnBoutonPerso.new("Rejouer")
    boutonQuitter = UnBoutonPerso.new("Quitter")

    boutonValider.set_size_request(200, -1)
    boutonRejouer.set_size_request(200, -1)
    boutonQuitter.set_size_request(200, -1)

    boutonValider.signal_connect('clicked'){
        Score.new(ent.get_text(), temps)
        boutonValider.set_sensitive(false);
    }

    boutonRejouer.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreMenuJouer.new(@@fenetre))
    }

    boutonQuitter.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreMenu.new(@@fenetre))
    }


    self.add(texteVict)
    self.add(texteEnt)
    fixedBoutons.put(ent, (size[0] / 2) - 100, 5)
    fixedBoutons.put(boutonValider, 50, 5)
    fixedBoutons.put(boutonRejouer, 50, 45)
    fixedBoutons.put(boutonQuitter, 50, 85)
    self.add(fixedBoutons)

  end

end
