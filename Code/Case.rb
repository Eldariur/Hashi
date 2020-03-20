#Classe permettant de définir une case
class Case

	## Partie variables d'instance

	# @x -> Coordonée X de la case
	# @y -> Coordonée Y de la case
	# @grille -> La grille dans laquelle la case se trouve
	# @contenu -> Le contenu de la case
	# @surbrillance -> Booleen qui defini si la case est en surbrillance ou non

    attr_accessor :surbrillance, :grille, :contenu
    attr_reader :x, :y

    ## Partie initialize

	# Initialisation de la class Case
	#
	# === Paramètres
	#
	# * +x+ : Coordonée X de la case
	# * +y+ : Coordonée Y de la case
    def initialize(x, y)
        @x = x
        @y = y
        @grille = nil
        @contenu = nil
        @surbrillance = false
    end

    ##Teste si la case a des voisins
    #
    # === Return
    #
    # True si a la case a au moins 1 voisin, false sinon
    def aSommetVoisin()
        if(@grille != nil)
            #puts "dimension de la grille : " + @grille.longueur.to_s + ":" + @grille.largeur.to_s
            #puts "test du voisin gauche, y = " + y.to_s
            boolSommetGauche = y-1 >= 0 ? @grille.getCase(x, y-1).contenu.is_a?(Sommet) : false
            #puts "test du voisin droit, y = " + y.to_s
            boolSommetDroit = y+1 < @grille.largeur ? @grille.getCase(x, y+1).contenu.is_a?(Sommet) : false
            #puts "test du voisin haut, x = " + x.to_s
            boolSommetHaut = x-1 >= 0 ? @grille.getCase(x-1, y).contenu.is_a?(Sommet) : false
            #puts "test du voisin bas, x = " + x.to_s
            boolSommetBas = x+1 < @grille.longueur ? @grille.getCase(x+1, y).contenu.is_a?(Sommet) : false
            return boolSommetGauche || boolSommetDroit || boolSommetHaut || boolSommetBas
        else
            return false
        end
    end

	##Teste si la case est une case voisine
	#
	# === Paramètre
	#
	# * +caseTest+ : la case a tester
	#
	# === Return
	#
	# True si la case est un voisin, false sinon
    def estVoisin(caseTest)
        difX = @x - caseTest.x
        difY = @y - caseTest.y
        return difX.abs() == 1 || difY.abs() == 1
    end

    ##Teste si la case est vide
    #Teste si la case a un contenu
    #
    # === Return
    #
    # True si la case n'a pas de contenu, false sinon
    def estVide()
      return @contenu==nil
    end

    def aArete()
        return contenu.class == Arete
    end

    def aSommet()
        return contenu.class == Sommet
    end

	##Affiche la case dans le terminal
    def afficher()
       if(@contenu == nil)
           print("·")
       else
           @contenu.afficher()
       end
   end
end
