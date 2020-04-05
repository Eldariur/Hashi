class BoutonTuto < Gtk::Button

  def initialize(str="", niveau = nil, labelNom="UnLabelPerso")
		super()

    self.add(UnLabelPerso.new(str))
    self.set_name("BoutonTuto")


		signal_connect("clicked") {
			puts("lancer tuto :"+niveau.to_s)

		}
  end

end
