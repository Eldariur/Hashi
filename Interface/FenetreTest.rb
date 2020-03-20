require 'gtk'

class FenetreTest < Gtk::Box

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    lbl1 = UnLabelPerso.new("Ceci est ma fenetre de test pour tester toutes les fenetres")

    tbl = Gtk::Table.new(3,3)
      # 9 case
      b1 = UnBoutonPerso.new("Classement")
      b2 = UnBoutonPerso.new("Jeu")
      b3 = UnBoutonPerso.new("Menu Principale")
      b4 = UnBoutonPerso.new("Menu Jeu")
      b5 = UnBoutonPerso.new("Contre-la-montre")
      b6 = UnBoutonPerso.new("Normal")
      b7 = UnBoutonPerso.new("Parametres")
      b8 = UnBoutonPerso.new("Regles")
      b9 = UnBoutonPerso.new("Fenetre de victoire")

      tbl.attach(b1,0,1,0,1)
      tbl.attach(b2,1,2,0,1)
      tbl.attach(b3,2,3,0,1)
      tbl.attach(b4,0,1,1,2)
      tbl.attach(b5,1,2,1,2)
      tbl.attach(b6,2,3,1,2)
      tbl.attach(b7,0,1,2,3)
      tbl.attach(b8,1,2,2,3)
      tbl.attach(b9,2,3,2,3)

      b1.signal_connect('clicked') {
        @@fenetre.changerWidget(FenetreClassement.new(@@fenetre))
      }
      b2.signal_connect('clicked') {
        @@fenetre.changerWidget(FenetreJeu.new(@@fenetre))
      }
      b3.signal_connect('clicked') {
        @@fenetre.changerWidget(FenetreMenu.new(@@fenetre))
      }
      b4.signal_connect('clicked') {
        @@fenetre.changerWidget(FenetreMenuJouer.new(@@fenetre))
      }
      b5.signal_connect('clicked') {
        @@fenetre.changerWidget(FenetreModeChrono.new(@@fenetre))
      }
      b6.signal_connect('clicked') {
        @@fenetre.changerWidget(FenetreModesDifficultes.new(@@fenetre))
      }
      b7.signal_connect('clicked') {
        @@fenetre.changerWidget(FenetreParametres.new(@@fenetre))
      }
      b8.signal_connect('clicked') {
        @@fenetre.changerWidget(FenetreRegle.new(@@fenetre))
      }
      b9.signal_connect('clicked') {
        @@fenetre.changerWidget(FenetreVictoire.new(@@fenetre))
      }




    self.add(lbl1)
    self.add(tbl)


  end

end
