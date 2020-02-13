class FenetreRegle < Gtk::Box

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    lbl1 = UnLabelPerso.new("Ceci est ma fenetre de règles (en construction)")
    self.add(lbl1)
  end

end
