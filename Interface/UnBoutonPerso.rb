class UnBoutonPerso < Gtk::Button

  def initialize(str="", nom="UnBoutonPerso", labelNom="UnLabelPerso")
		super()

    self.add(UnLabelPerso.new(str))
    self.set_name(nom)

    # self.signal_connect("enter"){
    #   print "c'est un bouton perso\n"
    # }
  end



end
