#Classe représentant une Arete
class Arete

    ## Partie variables d'instance

    # @sommet1 -> Sommet d'ou part l'arete
    # @sommet2 -> Sommet ou arrive l'arete
    # @estDouble -> Booleen définissant si une arete est double ou non
    # @listeCase -> Liste des case par lesquelles passe l'arete
    # @estErreur -> Booleen définissant si l'arete est une erreur ou non

    def self.creer(sommet1, sommet2, estDouble=false)
        objet = new(sommet1, sommet2, estDouble)
        objet.completerInitialize()
        return objet
    end

    private_class_method :new

    ## Partie initialize

	# Initialisation de la classe Arete
	#
	# === Paramètres
	#
	# * +sommet1+ : Sommet d'ou part l'arete
	# * +sommet2+ : Sommet ou s'arrete l'arete
    # * +estDouble+ : Booleen qui definie si l'arete est double (de base a false)
    def initialize(sommet1, sommet2, estDouble=false)
        @sommet1 = sommet1
        @sommet2 = sommet2
        @estDouble = estDouble
        @listeCase = Array.new()
        @estErreur = false

        #vérifie si le sommet1 est bien le plus en haut/a gauche, si c'est pas le cas, on échange les sommet1 et 2
        if(sommet1.position.x > sommet2.position.x || sommet1.position.y > sommet2.position.y)
            sommetMem = @sommet1
            @sommet1 = sommet2
            @sommet2 = sommetMem
        end
    end

    ## Partie accesseurs

    # Accesseur get sur les sommet, la liste des case
    attr_reader :sommet1, :sommet2, :listeCase

    # Accesseur get et set sur le booleen de l'arete
    attr_accessor :estDouble, :estErreur

    ## Partie méthodes

    ##Methode qui termine la creation d'une arete
    # complete son tableau de case et s'ajoute aux sommet, a la grille, et aux case par lesquelles elle passe
    def completerInitialize()
        plusX = @sommet1.position.x - @sommet2.position.x == 0 ? 0 : 1
        plusY = @sommet1.position.y - @sommet2.position.y == 0 ? 0 : 1

        laMatrice = @sommet1.position.grille.table
        caseAct = laMatrice[@sommet1.position.x + plusX, @sommet1.position.y + plusY]
        loop do
                @listeCase.push(caseAct)
                caseAct.contenu = self
                caseAct = laMatrice[caseAct.x + plusX, caseAct.y + plusY]
            break if caseAct.class == NilClass || caseAct.contenu == @sommet2
        end
        @sommet1.ajouterArete(self)
        @sommet2.ajouterArete(self)
        @sommet1.position.grille.addArete(self)
    end

    ##Donne la taille de l'arete
    #Donne la longueur du tableau de case
    #
    # === Return
    #
    # retourne la taille de la liste des cases
    def getTaille()
        return @listeCase.length()
    end

    ##Supprime l'arete
    #Retire toute les references a l'arette dans les sommets, la grille et les case par lesquelles elle passe
    def supprimer()
        loop do
            break if @listeCase.length == 0
            laCase = @listeCase.shift()
            laCase.contenu = nil
        end
        @sommet1.position.grille.retirerArete(self)
        @sommet1.retirerArete(self)
        @sommet2.retirerArete(self)
    end

    ##Affiche l'arete dans le terminal
    def afficher()
      if(@sommet1.position.x==@sommet2.position.x)
        if(@estDouble)
          print("=")
        else
          print("-")
        end
      else
        if(@estDouble)
          print("‖")
        else
          print("|")
        end
      end
    end
end
