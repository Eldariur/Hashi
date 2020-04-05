class FenetreJeuTuto < FenetreJeu

  def initialize(window,diff,tuto)
    @@fenetre = window
    super(window,"easy",nil,tuto)


    # labelDidact = UnLabelPerso.new("Didacticiels","LabelTitre")
    # self.add(labelDidact)
    #
    # boutonTest = UnBoutonPerso.new("test")
    # self.add(boutonTest)

  end


end
