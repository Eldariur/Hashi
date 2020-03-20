require_relative 'Arete.rb'

#Class undo, permet de stocker les actions du joueurs
class Undo

	attr_reader :tabAction
	# @tabAction -> Stocke les arretes qu'il a jouer

	def Undo.creer()
		new()
	end

	attr_reader :tabAction

	#Privatise le new
	private_class_method :new

	#Initialisation de la class Undo
	#
	# Instancie la variable @tabAction en array
	def initialize()
		@tabAction = Array.new
	end

	# empile la dernière Arete ajouter dans la grile
	#
	# ===Paramètres
	# * +arete+ : Ajout de la dernière arete jouer par le joueur
	def empile(arete)
		@tabAction.push(arete)
	end

	# empile la dernière Arete ajouter dans la grile
	#
	# ===Paramètres
	# * +arete+ : depile la dernière arete jouer par le joueur
	def depile()
		return @tabAction.pop()
	end

	@Override
	def to_s()
		return "Array Undo : " +  @tabAction.to_s()
	end

end
