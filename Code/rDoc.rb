##Programme pour voir l'utilisation de rdoc, pour compiler la documentation, rdoc nom.rb, pour voir si il manque des commentaires, rdoc nom.rb -C


# Classe permettant de détailler l'utilisation de la doc
class Doc
	##Partie variables d'instance
	#Variables d'instances de la classe Doc
	#@nom1 -> Détails rapide de la variables 
	#@nom2 -> Pareil
	#@nom3 -> Défini de base dans la classe
	def Doc.creer(param1,param2)
		new(param1,param2)
	end

	#Privatise le new
	private_class_method :new

	##Intialise
	
	#Initialisation de la class Doc
	#@param : param1 petite définition(Son nom,une date ...)
	#@param : param2 idem
	
	def initialize(param1,param2)
		@nom1 = param1
		@nom2 = param2
		@nom3 = "TEST"
	end

	##Partie Autorisation
	#Autorise les autres classes à lire
	attr_reader :nom1

	#Autorise les autres classes à ecrire
	attr_writer :nom2

	#Autorise les autres classes à lire et à écrire
	attr_accessor :nom3

	##Partie méthode
	##Methode sans param et renvoie rien
	#Détails juste ce que réalise la méthode
	def test1()
		puts @nom1
	end

	##Methode avec param mais renvoie rien
	#Détails juste ce que réalise la méthode
	#@param : param avec une description 
	def test2(param)
		puts @nom2.to_s + " " + param
	end

	##Methode avec param plus renvoie
	#Détails juste ce que réalise la méthode
	#@param : param avec une description 
	#@return : param avec une description 
	def test3(param)
		puts @nom2 +param
		return @nom3
	end

	
	def test4()
		print "coucou"
	end

	##Methode non commenter, pour tester rDoc -C

end
	

	
d = Doc.creer("Oui",1)
d.test1()
d.test2("COUCOU")
retour = d.test3(3)
puts retour
