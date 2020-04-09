require_relative "../Classement/Score.rb"

class FenetreVictoire < Gtk::Box

  def initialize(window, difficulte, temps="00:00", malus=0, nbAide=0)
    @@fenetre = window
    size = @@fenetre.default_size()
    super(Gtk::Orientation::VERTICAL)

    if(temps != nil && temps != "00:00")
        texteVict = UnLabelPerso.new("Félicitations, vous avez terminé cette grille en #{temps}", "lblRegles")
    else
        texteVict = UnLabelPerso.new("Félicitations, vous avez terminé cette grille", "lblRegles")
    end
    texteNbAide = UnLabelPerso.new("Vous avez utilisé #{nbAide} aides", "lblRegles")
    scoreHolder = Score.creer("placeholder", temps, difficulte)
    texteScore = UnLabelPerso.new("Votre score est de #{scoreHolder.points}", "lblRegles")
    texteEnt = UnLabelPerso.new("Saisissez votre pseudonyme :", "lblRegles")

    tbl = Gtk::Table.new(1,1)

    ent = Gtk::Entry.new()
    ent.set_placeholder_text("Votre Pseudo ici")
    ent.set_size_request(size[0] / 5, -1)

    boutonValider = UnBoutonPerso.new("Enregistrer le score")
    boutonRejouer = UnBoutonPerso.new("Rejouer")
    boutonQuitter = UnBoutonPerso.new("Menu")

    boutonValider.set_size_request(size[0] / 5, -1)
    boutonRejouer.set_size_request(size[0] / 5, -1)
    boutonQuitter.set_size_request(size[0] / 5, -1)

    boutonValider.signal_connect('clicked'){
        if(ent.text() != nil && ent.text().strip != "")
            score = Score.creer(ent.text(), temps, difficulte)
            score.sauvegarder()
            boutonValider.verrouiller()
            boutonValider.label = "Score enregistré"
        end
    }

    boutonRejouer.signal_connect('clicked') {
        if(temps != nil && temps != "00:00")
            @@fenetre.changerWidget(FenetreModeChrono.new(@@fenetre, FenetreMenuJouer.new(@@fenetre, FenetreMenu.new(@@fenetre))))
        else
            @@fenetre.changerWidget(FenetreModesDifficultes.new(@@fenetre, FenetreMenuJouer.new(@@fenetre, FenetreMenu.new(@@fenetre))))
        end
    }

    boutonQuitter.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreMenu.new(@@fenetre))
    }

    vbox = Gtk::Box.new(Gtk::Orientation::VERTICAL, 5)
    vbox2 = Gtk::Box.new(Gtk::Orientation::VERTICAL, 0)
    vbox2.add(texteVict)
    vbox2.add(texteNbAide)
    if(temps != nil && temps != "00:00")
        vbox2.add(texteScore)
        vbox2.add(texteEnt)
    end
    vbox.add(vbox2)
    if(temps != nil && temps != "00:00")
        vbox.add(ent)
        vbox.add(boutonValider)
    end
    vbox.add(boutonRejouer)
    vbox.add(boutonQuitter)
    tbl.attach(vbox,0,1,0,1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0, @@fenetre.default_size[1] / 3)
    self.add(tbl)

  end

end
