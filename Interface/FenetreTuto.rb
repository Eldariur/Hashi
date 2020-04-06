class FenetreTuto < Gtk::Box

  def initialize(window, fenPre)
    @@fenetre = window
    puts window.to_s
    super(Gtk::Orientation::VERTICAL)


    labelDidact = UnLabelPerso.new("Didacticiels","LabelTitre")
    self.add(labelDidact)

    hboxPrincipale = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
    hboxPrincipale.halign = Gtk::Align::CENTER
    hboxPrincipale.valign = Gtk::Align::CENTER

    hboxVide = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
    hboxPrincipale.halign = Gtk::Align::CENTER
    hboxPrincipale.set_spacing(30)

    initBoxTutoBasique
    initBoxTutoAvance

    hboxPrincipale.add(@boxTutoBasique)
    hboxPrincipale.add(hboxVide)
    hboxPrincipale.add(@boxTutoAvance)

    self.add(hboxPrincipale)


  end

  def initBoxTutoBasique
    @boxTutoBasique = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    @boxTutoBasique.halign = Gtk::Align::CENTER

    labelBasique = UnLabelPerso.new("Débutant","LabelTitre2")

    boutonTutoB1 = BoutonTuto.new(@@fenetre,"1","D1")

    boutonTutoB2 = BoutonTuto.new(@@fenetre,"2","D2")
    boutonTutoB3 = BoutonTuto.new(@@fenetre,"3","D3")
    boutonTutoB4 = BoutonTuto.new(@@fenetre,"4","D4")

    boxBoutonTutoB = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
    boxBoutonTutoB.add(boutonTutoB1)
    boxBoutonTutoB.add(boutonTutoB2)
    boxBoutonTutoB.add(boutonTutoB3)
    boxBoutonTutoB.add(boutonTutoB4)

    @boxTutoBasique.add(labelBasique)
    @boxTutoBasique.add(boxBoutonTutoB)

  end

  def initBoxTutoAvance
    @boxTutoAvance = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    @boxTutoAvance.halign = Gtk::Align::CENTER

    labelAvance = UnLabelPerso.new("Avancé","LabelTitre2")

    boutonTutoA1 = BoutonTuto.new(@@fenetre,"1","A1")
    boutonTutoA2 = BoutonTuto.new(@@fenetre,"2","A2")
    boutonTutoA3 = BoutonTuto.new(@@fenetre,"3","A3")
    boutonTutoA4 = BoutonTuto.new(@@fenetre,"4","A4")
    boutonTutoA5 = BoutonTuto.new(@@fenetre,"5","A5")
    boutonTutoA6 = BoutonTuto.new(@@fenetre,"6","A6")
    boutonTutoA7 = BoutonTuto.new(@@fenetre,"7","A7")
    boutonTutoA8 = BoutonTuto.new(@@fenetre,"8","A8")
    boutonTutoA9 = BoutonTuto.new(@@fenetre,"9","A9")
    boutonTutoA10 = BoutonTuto.new(@@fenetre,"10","A10")
    boutonTutoA11 = BoutonTuto.new(@@fenetre,"11","A11")
    boutonTutoA12 = BoutonTuto.new(@@fenetre,"12","A12")


    boxBoutonTutoAL1 = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
    boxBoutonTutoAL2 = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
    boxBoutonTutoAL3 = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
    boxBoutonTutoAL1.add(boutonTutoA1)
    boxBoutonTutoAL1.add(boutonTutoA2)
    boxBoutonTutoAL1.add(boutonTutoA3)
    boxBoutonTutoAL1.add(boutonTutoA4)
    boxBoutonTutoAL2.add(boutonTutoA5)
    boxBoutonTutoAL2.add(boutonTutoA6)
    boxBoutonTutoAL2.add(boutonTutoA7)
    boxBoutonTutoAL2.add(boutonTutoA8)
    boxBoutonTutoAL3.add(boutonTutoA9)
    boxBoutonTutoAL3.add(boutonTutoA10)
    boxBoutonTutoAL3.add(boutonTutoA11)
    boxBoutonTutoAL3.add(boutonTutoA12)
    #
    @boxTutoAvance.add(labelAvance)
    @boxTutoAvance.add(boxBoutonTutoAL1)
    @boxTutoAvance.add(boxBoutonTutoAL2)
    @boxTutoAvance.add(boxBoutonTutoAL3)

  end



end
