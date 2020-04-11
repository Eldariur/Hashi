class FenetreRegle < Gtk::Box

  def initialize(window,fenpre)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    lbl1 = UnLabelPerso.new("	Bienvenue dans le jeu Hashiwokakero (Le hashi pour être plus rapide, ou en français 'construire des ponts'), est un jeu dans laquelle votre réflexion sera votre seul ami.
				Les règles sont simples, relier tous les sommets entre eux en créant des ponts, et oui il y à des sommets, mais ces sommets son plutôt spéciaux voyez-vous.
				Ils sont numérotés ! , cette numérotation annonce le nombre de ponts pouvant être liée à cette île, exemple : un sommet à 1 peut avoir qu'un seul pont,
				un sommet à 3 peut avoir 3 pont.
				Il faudra alors les compléter, par exemple un sommet à 5 devra avoir 5 ponts partant de ce sommet.
				Cependant, il n'existe que deux type de pont, simple et double, vous avez la base du hashi,
				je vous laisse découvrire ce magnifique monde.
				Au cas ou je remets un petit résumé si vous voulez relire les règles rapidement :
				-Tous les sommets doivent être reliés et complétés.
				-Uniquement des ponts doubles et simple, (dans tous les cas vous ne pouvez que faire ça comme pont dans notre jeu donc bon)
				-Chaque sommet à une numérotation, remplisser celui ci pour le valider. ","UnLabelBlanc")
    self.add(lbl1)
	boutonRetour = UnBoutonPerso.new("Retour","btnQuit")
	boutonRetour.signal_connect('clicked'){	
		@@fenetre.changerWidget(fenpre)
	}
	
	self.add(boutonRetour)
  end

end
