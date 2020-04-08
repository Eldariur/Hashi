
class FenetreParametres < Gtk::Box

  def initialize(window,fenPre)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)
    lbl1 = UnLabelPerso.new("Longueur de la grille: ", "UnLabelBlanc")
    lbl2 = UnLabelPerso.new("Largeur de la grille: ", "UnLabelBlanc")
    lbl3 = UnLabelPerso.new("Difficulté: ", "UnLabelBlanc")

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
      lengthScale.setValue(6+rand(0..3));
      heightScale.setValue(6+rand(0..4));
      densScale.setValue(35+rand(0..6));
      actualise([lengthScale,heightScale,densScale])
      lengthScale.layout.font_description.absolute_size=(50)
      # puts var.to_s
    }

    boutonNO.signal_connect('clicked') {
      lengthScale.setValue(7+rand(0..2));
      heightScale.setValue(9+rand(0..3));
      densScale.setValue(32+rand(0..7));
      actualise([lengthScale,heightScale,densScale])
    }

    boutonHA.signal_connect('clicked') {
      lengthScale.setValue(9+rand(0..1));
      heightScale.setValue(13+rand(0..1));
      densScale.setValue(32+rand(0..6));
      actualise([lengthScale,heightScale,densScale])
    }

	boutonRetour.signal_connect('clicked'){
		@@fenetre.changerWidget(fenPre)
	}


    boutonVal.signal_connect('clicked') {
      puts "longueur " + lengthScale.getValue().to_s()
      puts "largeur  " + heightScale.getValue().to_s()
      puts "densite  " + densScale.getValue().to_s()
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, fenPre, "custom", false, nil, lengthScale.getValue().round(), heightScale.getValue().round(), densScale.getValue().round()))
    }

    boutonRes.signal_connect('clicked') {
      lengthScale.setValue(7);
      heightScale.setValue(7);
      densScale.setValue(19);
    }

  end

  def actualise(scale)
    scale.each do|s|
      s.adjustment=(Gtk::Adjustment.new(s.getValue(), s.adjustment.lower, s.adjustment.upper, 1, 1, 1))
    end
  end


end

class UneScaleTaille < Gtk::Scale

  def initialize(orient=:HORIZONTAL,str="UneScalePerso")
		super(orient)
    self.set_name(str)
    @cur_value = 5

    self.set_range 5, 15
    self.set_digits 0
    self.set_size_request 500, 100
    self.set_value @cur_value

    self.signal_connect "value-changed" do |w|
        on_changed w
        print @cur_value.to_s+" "
    end
  end

  def on_changed widget
    @cur_value = widget.value
  end

  def setValue(val)
    @cur_value = val
    print @cur_value.to_s+" "
  end

  def getValue()
    return @cur_value
  end
end

class UneScaleDensite < Gtk::Scale

  def initialize(orient=:HORIZONTAL,str="UneScalePerso")
		super(orient)
    self.set_name(str)
    @cur_value = 19

    self.set_range 19, 45
    self.set_digits 0
    self.set_size_request 500, 100
    self.set_value @cur_value

    self.signal_connect "value-changed" do |w|
        on_changed w
        print @cur_value.to_s+" "
    end
  end

  def on_changed widget
    @cur_value = widget.value
  end

  def setValue(val)
    @cur_value = val
    print @cur_value.to_s+" "
  end

  def getValue()
    return @cur_value
  end

end
