# Classe permettant d'afficher la fenetre de jeu des tutoriels
class FenetreJeuTuto < FenetreJeu
  ## Partie variables d'instance

  # @fenetre -> la fenêtre principale du programme

  ## Partie initialize

	# Initialisation de la classe FenetreJeuTuto
	#
	# === Paramètres
	#
  # * +window+ : window la fenêtre principale du programme
  # * +fenPre+ : fenPre la fenêtre précédente
  # * +diff+ : la difficulté de la grille de jeu à créer
  # * +tuto+ : un objet de la classe Tutoriel

  def initialize(window,fenPre,diff,tuto)
    @fenetre = window
    super(window,fenPre,"easy",nil,tuto)
  end

end
