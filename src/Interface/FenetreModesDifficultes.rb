# Classe permettant d'afficher le menu des différents modes de difficultés du jeu
class FenetreModesDifficultes < Gtk::Box
  ## Partie variables d'instance

  # @fenetre -> la fenêtre principale du programme
  # @classe -> booléen indiquant quand la fenêtre de jeu est en mode Contre-la-montre


  ## Partie initialize

  # Initialisation de la classe FenetreClassement
  #
  # === Paramètres
  #
  # * +window+ : window la fenêtre principale du programme
  # * +fenetrePre+ : fenetrePre la fenêtre précédente

  def initialize(window,fenetrePre)
    @fenetre = window
	    super(Gtk::Orientation::VERTICAL)

    @classe = false

    tbl = Gtk::Table.new(1,1)
    vBox = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    bouton1 = UnBoutonPerso.new("Facile", "BoutonMenu")
    bouton2 = UnBoutonPerso.new("Normal", "BoutonMenu")
    bouton3 = UnBoutonPerso.new("Difficile", "BoutonMenu")
    bouton4 = UnBoutonPerso.new("Personnalisé", "BoutonMenu")
    boutonRetour = UnBoutonPerso.new("Retour","BoutonMenu")
    bouton1.signal_connect('clicked') {
      affichePopup("easy")
    }

    bouton2.signal_connect('clicked') {
      affichePopup("normal")
    }

    bouton3.signal_connect('clicked') {
      affichePopup("hard")
    }

    bouton4.signal_connect('clicked') {
      affichePopup("custom")
    }

   boutonRetour.signal_connect('clicked'){
	@fenetre.changerWidget(fenetrePre)
   }
    vBox.add(bouton1)
    vBox.add(bouton2)
    vBox.add(bouton3)
    vBox.add(bouton4)
    vBox.add(boutonRetour)
    tbl.attach(vBox,0,1,0,1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0, @fenetre.default_size[1] / 3)
    self.add(tbl)

    self.show_all

  end

  ## Méthode permettant d'afficher un popup en fonction de la difficulté choisie par l'utilisateur
  #
  # === Paramètres
  #
	# * +difficulte+ : La difficulté correspondant au bouton cliqué
  def affichePopup(difficulte)
    case difficulte
      when "easy"
        popup = Gtk::MessageDialog.new(:parent => @fenetre, :flags => :modal, :type => :question, :buttons => :none, :message => "Souhaitez-vous charger la dernière sauvegarde facile ?")
      when "normal"
        popup = Gtk::MessageDialog.new(:parent => @fenetre, :flags => :modal, :type => :question, :buttons => :none, :message => "Souhaitez-vous charger la dernière sauvegarde normale ?")
      when "hard"
        popup = Gtk::MessageDialog.new(:parent => @fenetre, :flags => :modal, :type => :question, :buttons => :none, :message => "Souhaitez-vous charger la dernière sauvegarde difficile ?")
      when "custom"
        popup = Gtk::MessageDialog.new(:parent => @fenetre, :flags => :modal, :type => :question, :buttons => :none, :message => "Souhaitez-vous charger la dernière sauvegarde personnalisée ?")
    end
    popup.add_buttons(["Charger la sauvegarde", :yes], ["Nouvelle Partie", :no], [Gtk::Stock::CANCEL, :reject])

    response = popup.run()

    if(difficulte == "custom")
      if(response == :yes)
        save = Sauvegarde.nouvelle(nil, nil, nil, difficulte)
        partie = save.charger()
        popup.destroy()
        if(partie == nil)
          popup = Gtk::MessageDialog.new(:parent => @fenetre, :flags => :modal, :type => :info, :buttons => :ok, :message => "Aucune sauvegarde, création d'une nouvelle partie")
          popup.run()
          popup.destroy()
          @fenetre.changerWidget(FenetreParametres.new(@fenetre, self))
        else
          @fenetre.changerWidget(FenetreJeu.new(@fenetre, self, difficulte, @classe, partie))
        end
      elsif(response == :no)
        @fenetre.changerWidget(FenetreParametres.new(@fenetre, self))
        popup.destroy()
      else
        popup.destroy()
      end
    else
      if(response == :yes)
        save = Sauvegarde.nouvelle(nil, nil, nil, difficulte)
        partie = save.charger()
        popup.destroy()
        if(partie == nil)
          popup = Gtk::MessageDialog.new(:parent => @fenetre, :flags => :modal, :type => :info, :buttons => :ok, :message => "Aucune sauvegarde, création d'une nouvelle partie")
          popup.run()
          popup.destroy()
        end
        @fenetre.changerWidget(FenetreJeu.new(@fenetre, self, difficulte, @classe, partie))
      elsif(response == :no)
        popup.destroy()
        @fenetre.changerWidget(FenetreJeu.new(@fenetre,self, difficulte, @classe))
      end
    end
  end

end
