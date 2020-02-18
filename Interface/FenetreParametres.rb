
class FenetreParametres < Gtk::Box

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)
    lbl1 = UnLabelPerso.new("Longueur de la grille: ")
    lbl2 = UnLabelPerso.new("Largeur de la grille: ")
    lbl3 = UnLabelPerso.new("Nombre d'îles: ")

    boutonVal = UnBoutonPerso.new("VALIDER")
    boutonRes = UnBoutonPerso.new("RESET")

    hb = Gtk::Box.new(:HORIZONTAL)
    hb.set_name("maBoxScale")



    self.add(lbl1)
    self.add(UneScalePerso.new())
    self.add(lbl2)
    self.add(UneScalePerso.new())
    self.add(lbl3)
    self.add(UneScalePerso.new())

  end


end

class UneScalePerso < Gtk::Scale

  def initialize(orient=:HORIZONTAL,str="UneScalePerso")
		super(orient)
    self.set_name(str)
    @cur_value = 0

    self.set_range 0, 100
    self.set_digits 0
    self.set_size_request 500, 100
    self.set_value @cur_value

    self.signal_connect "value-changed" do |w|
        on_changed w
        print @cur_value.to_s+""
    end
  end

  def on_changed widget
    @cur_value = widget.value
  end

end
