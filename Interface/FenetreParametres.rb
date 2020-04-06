
class FenetreParametres < Gtk::Box

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)
    lbl1 = UnLabelPerso.new("Longueur de la grille: ")
    lbl2 = UnLabelPerso.new("Largeur de la grille: ")
    lbl3 = UnLabelPerso.new("Difficulté: ")

    boutonEZ = UnBoutonPerso.new("EASY", "BoutonMenu")
    boutonNO = UnBoutonPerso.new("NORMAL", "BoutonMenu")
    boutonHA = UnBoutonPerso.new("HARD", "BoutonMenu")

    boutonVal = UnBoutonPerso.new("VALIDER", "BoutonMenu")
    boutonRes = UnBoutonPerso.new("REINITIALISER", "BoutonMenu")

    tbl = Gtk::Table.new(1,1)
    vb = Gtk::Box.new(Gtk::Orientation::VERTICAL)
    hb = Gtk::Box.new(:HORIZONTAL)
    hb.set_name("maBoxScale")

    lengthScale = UneScaleTaille.new()
    heightScale = UneScaleTaille.new()
    densScale = UneScaleDensite.new()

    self.add(lbl1)
    self.add(lengthScale)
    self.add(lbl2)
    self.add(heightScale)
    self.add(lbl3)
    self.add(densScale)

    vb.add(boutonEZ)
    vb.add(boutonNO)
    vb.add(boutonHA)

    vb.add(boutonVal)
    vb.add(boutonRes)
    tbl.attach(vb,0,1,0,1, Gtk::AttachOptions::EXPAND)
    self.add(tbl)

    boutonEZ.signal_connect('clicked') {
      lengthScale.setValue(6+rand(0..3));
      heightScale.setValue(6+rand(0..4));
      densScale.setValue(35+rand(0..6));
    }

    boutonNO.signal_connect('clicked') {
      lengthScale.setValue(7+rand(0..2));
      heightScale.setValue(9+rand(0..3));
      densScale.setValue(32+rand(0..7));
    }

    boutonHA.signal_connect('clicked') {
      lengthScale.setValue(9+rand(0..1));
      heightScale.setValue(13+rand(0..1));
      densScale.setValue(32+rand(0..6));
    }

    boutonVal.signal_connect('clicked') {
      puts "longueur " + lengthScale.getValue().to_s()
      puts "largeur  " + heightScale.getValue().to_s()
      puts "densite  " + densScale.getValue().to_s()
      @@fenetre.changerWidget(FenetreJeu.new(@@fenetre, nil, false, nil, lengthScale.getValue().round(), heightScale.getValue().round(), densScale.getValue().round()))
    }

    boutonRes.signal_connect('clicked') {
      lengthScale.setValue(5);
      heightScale.setValue(5);
      densScale.setValue(19);
    }

  end


end

class UneScaleTaille < Gtk::Scale

  def initialize(orient=:HORIZONTAL,str="UneScaleTaille")
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

  def initialize(orient=:HORIZONTAL,str="UneScaleDensite")
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
