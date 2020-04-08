require_relative "../Classement/Score.rb"

class FenetreVictoire < Gtk::Box

  def initialize(window,difficulte,temps="00:00")
    @@fenetre = window
    size = @@fenetre.default_size()
    super(Gtk::Orientation::VERTICAL)

    texteVict = UnLabelPerso.new("Félicitations, vous avez terminé cette grille en "+temps, "lblRegles")
    texteEnt = UnLabelPerso.new("Saisissez votre pseudonyme :", "lblRegles")

    fixedBoutons = Gtk::Fixed.new()
    tbl = Gtk::Table.new(1,1)

    ent = Gtk::Entry.new()
    ent.set_placeholder_text("Votre Pseudo ici")
    ent.set_size_request(size[0] / 5, -1)

    boutonValider = UnBoutonPerso.new("Valider")
    boutonRejouer = UnBoutonPerso.new("Rejouer")
    boutonQuitter = UnBoutonPerso.new("Menu")

    boutonValider.set_size_request(size[0] / 5, -1)
    boutonRejouer.set_size_request(size[0] / 5, -1)
    boutonQuitter.set_size_request(size[0] / 5, -1)

    boutonValider.signal_connect('clicked'){
        if(ent.text() != nil && ent.text().strip != "")
            score = Score.creer(ent.text(), temps, difficulte)
            score.sauvegarder()
            boutonValider.set_sensitive(false)
            boutonValider.label = "Score enregistré"
        end
    }

    boutonRejouer.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreMenuJouer.new(@@fenetre, FenetreMenu.new(@@fenetre)))
    }

    boutonQuitter.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreMenu.new(@@fenetre))
    }

    vbox = Gtk::Box.new(Gtk::Orientation::VERTICAL, 5)
    vbox2 = Gtk::Box.new(Gtk::Orientation::VERTICAL, 0)
    vbox2.add(texteVict)
    vbox2.add(texteEnt)
    vbox.add(vbox2)
    #fixedBoutons.put(ent, (size[0] / 2) - (size[0] / 5)/2, 5)
    #fixedBoutons.put(boutonValider, (size[0] / 2) - (size[0] / 5)/2, 20)
    #fixedBoutons.put(boutonRejouer, (size[0] / 2) - (size[0] / 5)/2, 60)
    #fixedBoutons.put(boutonQuitter, (size[0] / 2) - (size[0] / 5)/2, 100)
    vbox.add(ent)
    vbox.add(boutonValider)
    vbox.add(boutonRejouer)
    vbox.add(boutonQuitter)
    tbl.attach(vbox,0,1,0,1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0, @@fenetre.default_size[1] / 3)
    self.add(tbl)

  end

end
