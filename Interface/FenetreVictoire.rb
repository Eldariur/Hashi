require_relative "../Classement/Score.rb"

# Classe permettant d'afficher la fenêtre de l'écran de victoire du jeu
class FenetreVictoire < Gtk::Box
  ## Partie variables d'instance

  # @@fenetre -> la fenêtre principale du programme


  ## Partie initialize

  # Initialisation de la classe FenetreClassement
  #
  # === Paramètres
  #
  # * +window+ : window la fenetre principale du programme
  # * +difficulte+ : difficulte la difficulte de la grille de jeu précédemment effectuée
  # * +chr+ : chr le temps effectué pour faire la grille précédemment jouée
  def initialize(window, fenPre, difficulte, chr)
    @@fenetre = window
    
    size = @@fenetre.default_size()
    super(Gtk::Orientation::VERTICAL)

    if(chr != nil && chr.to_s != "00:00")
        texteVict = UnLabelPerso.new("Félicitations, vous avez terminé cette grille en #{chr.to_s}", "lblRegles")
	texteMalus = UnLabelPerso.new("Vous avez un malus de #{chr.malus} secondes", "lblRegles")
	scoreHolder = Score.creer("placeholder",chr.resultat, difficulte)
	newScore = Classement.creer(difficulte).isHighScore?(scoreHolder)
	texteScore = UnLabelPerso.new("Votre score est de #{scoreHolder.calculScore.round.to_s}", "lblRegles")
	if(newScore)
		texteEnt = UnLabelPerso.new("C'est un nouveau record ! Saisissez votre pseudonyme :", "lblRegles")
	end
    else
        texteVict = UnLabelPerso.new("Félicitations, vous avez terminé cette grille", "lblRegles")
    end

    tbl = Gtk::Table.new(1,1)
    if(newScore)
	ent = Gtk::Entry.new()
	ent.set_placeholder_text("Votre Pseudo ici")
	ent.set_size_request(size[0] / 5, -1)
    	boutonValider = UnBoutonPerso.new("Enregistrer le score")
	boutonValider.set_size_request(size[0] / 5, -1)
	boutonValider.signal_connect('clicked'){
        if(ent.text() != nil && ent.text().strip != "")
	    scoreHolder.pseudo = ent.text
            scoreHolder.sauvegarder()
            @@fenetre.changerWidget(FenetreClassement.new(@@fenetre, FenetreMenu.new(@@fenetre)))
        end
    	}
    end
    
    boutonRejouer = UnBoutonPerso.new("Rejouer")
    boutonQuitter = UnBoutonPerso.new("Menu")

    boutonRejouer.set_size_request(size[0] / 5, -1)
    boutonQuitter.set_size_request(size[0] / 5, -1)


    boutonRejouer.signal_connect('clicked') {
            @@fenetre.changerWidget(fenPre)
    }

    boutonQuitter.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreMenu.new(@@fenetre))
    }

    vbox = Gtk::Box.new(Gtk::Orientation::VERTICAL, 5)
    vbox2 = Gtk::Box.new(Gtk::Orientation::VERTICAL, 0)
    vbox2.add(texteVict)
    if(chr != nil && chr.to_s != "00:00")
        vbox2.add(texteMalus)
        vbox2.add(texteScore)
        if(newScore)
		vbox2.add(texteEnt)
	end
    end
    vbox.add(vbox2)
    if(chr != nil && chr.to_s != "00:00" && newScore)
	vbox.add(ent)
        vbox.add(boutonValider)
    end
    vbox.add(boutonRejouer)
    vbox.add(boutonQuitter)
    tbl.attach(vbox,0,1,0,1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0, @@fenetre.default_size[1] / 3)
    self.add(tbl)

  end

end
