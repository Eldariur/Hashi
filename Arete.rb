#Classe représentant une arete
class Arete

    ##Partie variable d'instance

    #@sommet1   -> Sommet d'ou part l'arete
    #@sommet2   -> Sommet ou s'arrete l'arete
    #estDouble  -> Boolean qui définie si l'arete est une double arete ou non
    #listeCase  -> Liste des cases par lesquelles passe l'arete

    #creer une arete proprement
    def self.creer(sommet1, sommet2, estDouble=false)
        objet = new(sommet1, sommet2, estDouble)
        objet.completerInitialize()
        return objet
    end


    private_class_method :new

    ## Partie initialize

    #Initialisation de la classe Arete
    #
    # === Paramètres
    #
    # * +sommet1+ : Sommet d'ou part l'arete
    # * +sommet2+ : Sommet ou s'arrete l'arete
    # * +estDouble+ : Boolean qui définie si l'arete est une double arete ou non

    def initialize(sommet1, sommet2, estDouble=false)
        @sommet1 = sommet1
        @sommet2 = sommet2
        @estDouble = estDouble
        @listeCase = Array.new()

        #vérifie si le sommet1 est bien le plus en haut/a gauche, si c'est pas le cas, on échange les sommet1 et 2
        if(sommet1.position.x > sommet2.position.x || sommet1.position.y > sommet2.position.y)
            sommetMem = @sommet1
            @sommet1 = sommet2
            @sommet2 = sommetMem
        end
    end

    #Fini l'initialisation de l'arete
    #
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

    ##Partie accesseurs

    # Accesseur get sur l'attribut les sommets, la liste des case et le booleen estDouble
	attr_reader :sommet1, :sommet2, :listeCase, :estDouble

    ##Partie méthode

    ##Methode calculant la taille de l'arete
    #Donne la taille du tableau de case
    #
    # === Return
    #
    # Un int correspondant a la taille du tableau
    def getTaille()
        return @listeCase.length()
    end

    ##Methode supprimant l'arete
    #L'arete se retire des contenant des sommets, de la grille et des cases par ou elle passe
    def supprimer()
        loop do
            break if @listeCase.length == 0
            laCase = @listeCase.shift()
            laCase.ajouterContenu(nil)
        end
        @sommet1.position.grille.retirerArete(self)
        @sommet1.retirerArete(self)
        @sommet2.retirerArete(self)
    end

    #Affiche l'arete
    #affiche une chaine de charactere sur le terminal pour l'affichage terminal
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
