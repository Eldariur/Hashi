# Classe permettant d'afficher la fenetre de jeu paramètrable
class FenetreParametres < Gtk::Box
  ## Partie variables d'instance

  # @fenetre -> la fenêtre principale du programme
  # @cur_value -> le nombre de colonne du classement


  ## Partie initialize

  # Initialisation de la classe FenetreParametres
  #
  # === Paramètres
  #
  # * +window+ : window la fenêtre principale du programme
  # * +fenPre+ : fenPre la fenêtre précédente
  def initialize(window,fenPre)
    @fenetre = window
    super(Gtk::Orientation::VERTICAL)
    lbl1 = UnLabelPerso.new("Longueur de la grille: ", "UnLabelBlanc")
    lbl2 = UnLabelPerso.new("Largeur de la grille: ", "UnLabelBlanc")
    lbl3 = UnLabelPerso.new("Densité : ", "UnLabelBlanc")

    boutonEZ = UnBoutonPerso.new("Easy", "BoutonMenu")
    boutonNO = UnBoutonPerso.new("Normal", "BoutonMenu")
    boutonHA = UnBoutonPerso.new("Hard", "BoutonMenu")

    boutonVal = UnBoutonPerso.new("Valider", "BoutonMenu")
    boutonRes = UnBoutonPerso.new("Réinitialiser", "BoutonMenu")
    boutonRetour = UnBoutonPerso.new("Retour","BoutonMenu")


    tbl = Gtk::Table.new(1,1)
    vb = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    hb = Gtk::Box.new(:HORIZONTAL)
    hb.set_name("maBoxScale")

    lengthScale = UneScaleTaille.new()
    heightScale = UneScaleTaille.new()
    densScale = UneScaleDensite.new()

    vb.add(lbl1)
    vb.add(lengthScale)
    vb.add(lbl2)
    vb.add(heightScale)
    vb.add(lbl3)
    vb.add(densScale)

    vb.add(boutonEZ)
    vb.add(boutonNO)
    vb.add(boutonHA)

    vb.add(boutonVal)
    vb.add(boutonRes)
    vb.add(boutonRetour)

    tbl.attach(vb,0,1,0,1, Gtk::AttachOptions::EXPAND)
    self.add(tbl)

    boutonEZ.signal_connect('clicked') {
      lengthScale.value=(6+rand(0..3));
      heightScale.value=(6+rand(0..4));
      densScale.value=(35+rand(0..6));
      actualise([lengthScale,heightScale,densScale])
      lengthScale.layout.font_description.absolute_size=(50)
    }

    boutonNO.signal_connect('clicked') {
      lengthScale.value=(7+rand(0..2));
      heightScale.value=(9+rand(0..3));
      densScale.value=(32+rand(0..7));
      actualise([lengthScale,heightScale,densScale])
    }

    boutonHA.signal_connect('clicked') {
      lengthScale.value=(9+rand(0..1));
      heightScale.value=(13+rand(0..1));
      densScale.value=(32+rand(0..6));
      actualise([lengthScale,heightScale,densScale])
    }

	boutonRetour.signal_connect('clicked'){
		@fenetre.changerWidget(fenPre)
	}


    boutonVal.signal_connect('clicked') {
      @fenetre.changerWidget(FenetreJeu.new(@fenetre, fenPre, "custom", false, nil, lengthScale.getValue().round(), heightScale.getValue().round(), densScale.getValue().round()))
    }

    boutonRes.signal_connect('clicked') {
      lengthScale.value=(7);
      heightScale.value=(7);
      densScale.value=(19);
      actualise([lengthScale,heightScale,densScale])
    }

  end

  ## Methode avec paramètres permettant d'actualiser le curseur en fonction de sa valeur
	#
	# === Paramètres
	#
	# * +scale+ : scale le curseur devant être actualisé
  def actualise(scale)
    scale.each do|s|
      s.adjustment=(Gtk::Adjustment.new(s.getValue(), s.adjustment.lower, s.adjustment.upper, 1, 1, 1))
    end
  end


end

# Classe représentant un curseur personnalisé pour définir la taille de la grille de jeu
class UneScaleTaille < Gtk::Scale
  ## Partie variables d'instance

  # @cur_value -> la valeur à laquelle est positionné le curseur

  ## Partie initialize

  # Initialisation de la classe UneScaleTaille
  #
  # === Paramètres
  #
  # * +orient+ : orient l'orientation du curseur
  # * +str+ : str le nom donné au curseur pour pouvoir l'identifier
  def initialize(orient=:HORIZONTAL,str="UneScalePerso")
		super(orient)
    self.set_name(str)
    @cur_value = 7

    self.set_range 5, 15
    self.set_digits 0
    self.set_size_request 500, 100
    self.value= @cur_value

    self.signal_connect "value-changed" do |w|
        on_changed w
    end
  end

  ## Partie méthodes

  ## Méthode avec paramètres permettant de détecter un changement sur le curseur
  # et de modifier la valeur correspondant à celle-ci
  #
  # === Paramètres
  #
  # * +widget+ : widget le widget dont on récupère la valeur
  def on_changed widget
    @cur_value = widget.value
  end

  ## Partie méthodes

  ## Méthode sans paramètres permettant de donner la valeur de positionnement du curseur
  #
  # === Return
  #
  # * +cur_value+ : la valeur de positionnement du curseur
  def getValue()
    return @cur_value
  end
end

# Classe représentant un curseur personnalisé pour définir la densité de la grille de jeu
class UneScaleDensite < Gtk::Scale

  ## Partie variables d'instance

  # @cur_value -> la valeur à laquelle est positionné le curseur

  ## Partie initialize

  # Initialisation de la classe UneScaleDensite
  #
  # === Paramètres
  #
  # * +orient+ : orient l'orientation du curseur
  # * +str+ : str le nom donné au curseur pour pouvoir l'identifier
  def initialize(orient=:HORIZONTAL,str="UneScalePerso")
		super(orient)
    self.set_name(str)
    @cur_value = 19

    self.set_range 19, 45
    self.set_digits 0
    self.set_size_request 500, 100
    self.value= @cur_value

    self.signal_connect "value-changed" do |w|
        on_changed w
    end
  end

  ## Partie méthodes

  ## Méthode avec paramètres permettant de détecter un changement sur le curseur
  # et de modifier la valeur correspondant à celle-ci
  #
  # === Paramètres
  #
  # * +widget+ : widget le widget dont on récupère la valeur
  def on_changed widget
    @cur_value = widget.value
  end

  ## Partie méthodes

  ## Méthode sans paramètres permettant de donner la valeur de positionnement du curseur
  #
  # === Return
  #
  # * +cur_value+ : la valeur de positionnement du curseur
  def getValue()
    return @cur_value
  end

end
