class UnLabelPerso < Gtk::Label

  def initialize(str="", nom="UnLabelPerso")
		super(str)

		self.name=nom
	end

end
