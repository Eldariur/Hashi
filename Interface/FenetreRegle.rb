class FenetreRegle < Gtk::Box

  def initialize(window,fenpre)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    tbl = Gtk::Table.new(1,1)

    lbl1 = UnLabelPerso.new("	Bienvenu dans le jeu Hashiwokakero (Le hashi pour être plus rapide, ou en français 'construire des ponts'), est un jeu dans laquelle votre réflexion sera votre seul ami.
				Les règles sont simples, relier tous les sommets entre eux en créant des ponts, et oui il y a des sommets, mais c'est sommets sont plus tôt spéciaux voyez-vous.
				Ils sont numérotés ! , cette numérotation annonce le nombre de ponts pouvant être liée a cette île, exemple : un sommet à 1 peut avoir qu'un seul pont,
				un sommet à 3 peut avoir 3 pont.
				Il faudra alors les completer, par exemple un sommet a 5 devra avoir 5 ponts partant de ce sommet.
				Cependant, il n'existe que deux type de pont, simple et double, vous avez la base du hashi,
				je vous laisse découvrire ce magnifique monde.
				Au cas ou je remets un petit debrief si vous voulez relire les règles rapidement :
				-Tous les sommets doivent être relier et completer.
				-Uniquement des ponts doubles et simple, ( dans tous les cas vous pouvez faire que ça comme pont dans notre jeu donc bon)
				-Chaque sommet à une numérotation, remplisser celui ci pour le valider. ","UnLabelBlanc")

    boutonRetour = UnBoutonPerso.new("Retour","BoutonMenu")

    boutonRetour.signal_connect('clicked'){
      @@fenetre.changerWidget(fenpre)
    }

    tbl.attach(boutonRetour, 0, 1, 1, 2, Gtk::AttachOptions::SHRINK)
    tbl.attach(lbl1,0,1,0,1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0, @@fenetre.default_size[1] / 4)
    self.add(tbl)
  end

end
