class FenetreClassement < Gtk::Box

  def initialize(window)
    @@fenetre = window
    @nbCol = 4
    @nbLig = 0
    @rang = 0

    super(Gtk::Orientation::VERTICAL)

    lbl0 = UnLabelPerso.new("Ceci est ma fenetre de classement (en construction)")
    self.add(lbl0)

    @tbl = Gtk::Table.new(@nbCol,@nbLig)
    @tbl.set_name("TableDesScores")
      lbl1 = UnLabelPerso.new("RANG")
      lbl2 = UnLabelPerso.new("Pseudo")
      lbl3 = UnLabelPerso.new("Score")

      @tbl.attach(lbl2,0,1,0,1)
      @tbl.attach(lbl1,1,3,0,1)
      @tbl.attach(lbl3,3,4,0,1)

      self.add(@tbl)
      btn = Gtk::Button.new("test")
      btn.signal_connect('clicked'){
        ajouterLig("Jaco","10000")
      }
      self.add(btn)
  end

  def ajouterLig(pseudo = "",scr = "0")
    @nbLig +=1
    @rang += 1
    @tbl.resize(@nbCol,@nbLig)
    @tbl.attach(UnLabelPerso.new(@rang.to_s),0,1,@nbLig,@nbLig+1)
    @tbl.attach(UnLabelPerso.new(pseudo),1,3,@nbLig,@nbLig+1)
    @tbl.attach(UnLabelPerso.new(scr),3,4,@nbLig,@nbLig+1)

    self.add(@tbl)
    @@fenetre.changerWidget(self)
  end

end
