class BoutonTuto < Gtk::Button

  def initialize(window,fenPre,str="", niveau = nil, labelNom="UnLabelPerso")
		super()


    @@fenetre = window
    self.add(UnLabelPerso.new(str))
    self.set_name("BoutonTuto")
    tuto = Tutoriel.new(niveau)

		signal_connect("clicked") {
			puts("lancer tuto :"+niveau.to_s)
      puts tuto.getMessageTuto()+"======"
      #tuto.lancerTuto()

      # (window, difficulte, classe, save = nil, long=nil, larg=nil, dens=nil, tuto = nil)
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre,fenPre,'easy', false, nil, nil, nil, nil, tuto))

		}
  end

end
