# Classe permettant de définir un label personnifié et facilement modifiable, hérite de la classe Gtk::Label
class UnLabelPerso < Gtk::Label
  ## Partie initialize

  # Initialisation de la classe UnLabelPerso
  #
  # === Paramètres
  #
  # * +str+ : str la chaîne de caractère comprise dans le label
  # * +nom+ : nom le nom donné au label afin de pouvoir le modifier par la suite
  def initialize(str="", nom="UnLabelPerso")
		super(str)

		self.name=nom
	end

end
