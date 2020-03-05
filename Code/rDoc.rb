## Programme pour voir l'utilisation de rdoc, pour compiler la documentation, rdoc nom.rb, pour voir si il manque des commentaires, rdoc nom.rb -C


# Classe permettant de détailler l'utilisation de la doc
class Doc



	## Partie variables d'instance

	# @nom1 -> Détails rapide de la variables
	# @nom2 -> Pareil
	# @nom3 -> Défini de base dans la classe

	def Doc.creer(param1, param2)
		new(param1, param2)
	end

	# Privatise le new
	private_class_method :new



	## Partie initialize

	# Initialisation de la class Doc
	#
	# === Parametre
	#
	# * +param1+ : param1 petite définition(Son nom,une date ...)
	# * +param2+ : param2 idem
	def initialize(param1, param2)
		@nom1 = param1
		@nom2 = param2
		@nom3 = "TEST"
	end



	## Partie accesseurs

	# Accesseur get sur l'attribut nom1
	attr_reader :nom1

	# Accesseur set sur l'attribut nom1
	attr_writer :nom2

	# Accesseur get et set sur l'attribut nom1
	attr_accessor :nom3



	## Partie méthodes

	## Methode sans param et renvoie rien
	# Détails juste ce que réalise la méthode
	def test1()
		puts @nom1
	end

	## Methode avec param mais renvoie rien
	# Détails juste ce que réalise la méthode
	#
	# === Parametre
	#
	# * +param+ : param avec une description
	def test2(param)
		puts @nom2.to_s + " " + param
	end

	## Methode avec param plus renvoie
	# Détails juste ce que réalise la méthode
	#
	# === Parametre
	#
	# * +param+ : param avec une description
	#
	# === Return
	#
	# * +@nom3+ : param avec une description
	def test3(param)
		puts @nom2 +param
		return @nom3
	end


	def test4()
		print "coucou"
	end

	## Methode non commenter, pour tester rDoc -C

end



d = Doc.creer("Oui",1)
d.test1()
d.test2("COUCOU")
retour = d.test3(3)
puts retour
