
require_relative 'FenetreModeChrono.rb'

class FenetreModesDifficultes < Gtk::Box

  #@classe

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    @classe = false

    tbl = Gtk::Table.new(1,1)
    vBox = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    bouton1 = UnBoutonPerso.new("Facile", "BoutonMenu")
    bouton2 = UnBoutonPerso.new("Normal", "BoutonMenu")
    bouton3 = UnBoutonPerso.new("Difficile", "BoutonMenu")
    bouton4 = UnBoutonPerso.new("Personnalisé", "BoutonMenu")

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
      @@fenetre.changerWidget(FenetreParametres.new(@@fenetre))
    }

    vBox.add(bouton1)
    vBox.add(bouton2)
    vBox.add(bouton3)
    vBox.add(bouton4)
    tbl.attach(vBox,0,1,0,1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0, @@fenetre.default_size[1] / 3)
    self.add(tbl)

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
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, difficulte, @classe, partie))
    elsif(response == :no)
      popup.destroy()
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, difficulte, @classe))
    end

    popup.destroy()
  end

end
