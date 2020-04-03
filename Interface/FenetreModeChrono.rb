class FenetreModeChrono < Gtk::Box

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    bouton1 = UnBoutonPerso.new("Facile")
    bouton2 = UnBoutonPerso.new("Normal")
    bouton3 = UnBoutonPerso.new("Difficile")

    bouton1.signal_connect('clicked') {
      affichePopup("easy")
    }

    bouton2.signal_connect('clicked') {
      affichePopup("normal")
    }

    bouton3.signal_connect('clicked') {
      affichePopup("hard")
    }

    self.add(bouton1)
    self.add(bouton2)
    self.add(bouton3)

    self.show_all

  end

  ## Méthode permettant d'afficher un popup en fonction de la difficulté choisie par l'utilisateur
  #
  # === Return
  #
	# * +id+ : Id de l'aide
  def affichePopup(difficulte)
    case difficulte
      when "easy"
        popup = Gtk::MessageDialog.new(@@fenetre, :modal, :question, :none, "Souhaitez-vous charger la dernière sauvegarde facile ?")
      when "normal"
        popup = Gtk::MessageDialog.new(@@fenetre, :modal, :question, :none, "Souhaitez-vous charger la dernière sauvegarde normale ?")
      when "hard"
        popup = Gtk::MessageDialog.new(@@fenetre, :modal, :question, :none, "Souhaitez-vous charger la dernière sauvegarde difficile ?")
    end
    popup.add_buttons(["Charger la sauvegarde", :yes], ["Nouvelle Partie", :no], [Gtk::Stock::CANCEL, :reject])

    response = popup.run()

    if(response == :yes)
      save = Sauvegarde.nouvelle(nil, nil, nil, difficulte)
      partie = save.charger()
      popup.destroy()
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, difficulte, partie))
    elsif(response == :no)
      popup.destroy()
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, difficulte))
    end

    popup.destroy()
  end

end
