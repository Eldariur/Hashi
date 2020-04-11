class FenetreRegle < Gtk::Box

  def initialize(window,fenpre)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    lbl1 = UnLabelPerso.new("	Bienvenue dans le jeu Hashiwokakero (Le hashi pour être plus rapide, ou en français 'construire des ponts'), est un jeu dans laquelle votre réflexion sera votre seule amie.
				Les règles sont simples, relier tous les sommets entre eux en créant des ponts, et oui il y a des sommets, mais ces sommets sont plutôt spéciaux voyez-vous.
				Ils sont numérotés ! , cette numérotation annonce le nombre de ponts pouvant être liés à cette île, exemple : un sommet à 1 ne peut avoir qu'un seul pont,
				un sommet à 3 peut avoir 3 ponts.
				Il faudra alors les compléter, par exemple un sommet à 5 devra avoir 5 ponts partants de ce sommet.
				Cependant, il n'existe que deux types de pont, simple et double, vous avez la base du hashi,
				je vous laisse découvrir ce magnifique monde.
				Au cas où je remets un petit résumé si vous voulez relire les règles rapidement :
				- Tous les sommets doivent être reliés et complétés.
				- Uniquement des ponts doubles et simples, (dans tous les cas vous ne pouvez que faire ça comme pont dans notre jeu donc bon)
				- Chaque sommet à une numérotation, remplissez celui-ci pour le valider. ","UnLabelBlanc")
    self.add(lbl1)
	boutonRetour = UnBoutonPerso.new("Retour","btnQuit")
	boutonRetour.signal_connect('clicked'){
		@@fenetre.changerWidget(fenpre)
	}

	self.add(boutonRetour)
  end

end
