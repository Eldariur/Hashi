require_relative '../Plateau/Arete.rb'

#Class Undo, permet de stocker les actions du joueurs
class Undo

	##Partie variables d'instance

	# @tabAction -> Stocke les arêtes qu'il a joué

	# Créer un objet Undo
	def Undo.creer()
		new()
	end

	##Partie accesseurs

	#Accesseur read sur l'attribut tabAction
	attr_reader :tabAction

	#Privatise le new
	private_class_method :new


	##Partie initialize

	#Initialisation de la class Undo.
	#
	#Instancie la variable @tabAction en array.
	def initialize()
		@tabAction = Array.new
	end

	# empile la dernière Arete ajoutée dans la grille
	#
	# ===Paramètres
	# * +arete+ : Ajout de la dernière arête jouée par le joueur
	def empile(arete)
		@tabAction.push(arete)
	end

	# empile la dernière Arete ajoutée dans la grille
	#
	# ===Returne
	# * +arete+ : dépile la dernière arête jouée par le joueur
	def depile()
		return @tabAction.pop()
	end

	#Redéfinition de la méthode to_s pour l'affichage de undo
	#
	# ===Return
	# * +string+ * : renvoie une version en string de la pile
	@Override
	def to_s()
		return "Array Undo : " +  @tabAction.to_s()
	end

end
