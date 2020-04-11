class FenetreRegle < Gtk::Box

  def initialize(window,fenpre)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    tbl = Gtk::Table.new(1,1)

    lbl1 = UnLabelPerso.new("Bienvenue dans le jeu Hashiwokakero (Le hashi pour être plus rapide, ou en français 'construire des ponts').

Les règles sont simples, relier tous les sommets entre eux en créant des ponts.
Les sommets sont numérotés. Cette numérotation indique le nombre de ponts devant être liés à cette île.
Exemples : un sommet à 1 doit et ne peut avoir qu'un seul pont et un sommet à 3 doit avoir trois ponts.
Le but du jeu est de compléter tout les sommets.
Il est possible de relier deux mêmes îles avec deux ponts au maximum.
Il n'est possible de relier deux îles que si elles partagent la même colonne ou la même ligne et si aucun pont ne les séparent.

Résumé des règles :
  - Tous les sommets doivent être reliés et complétés.
  - Uniquement des ponts simples ou doubles.
  - Chaque sommet est numéroté, relier-le à d'autres avec le nombre de ponts correspondant pour le compléter. ","UnLabelBlanc")

    boutonRetour = UnBoutonPerso.new("Retour","BoutonMenu")

    boutonRetour.signal_connect('clicked'){
      @@fenetre.changerWidget(fenpre)
    }

    tbl.attach(boutonRetour, 0, 1, 1, 2, Gtk::AttachOptions::SHRINK)
    tbl.attach(lbl1,0,1,0,1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0, @@fenetre.default_size[1] / 4)
    self.add(tbl)
  end

end
