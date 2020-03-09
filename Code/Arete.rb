class Arete
    #@direction
    #@sommet1
    #@sommet2

    #creer une arete proprement
    def self.creer(sommet1, sommet2, estDouble=false)
        objet = new(sommet1, sommet2, estDouble)
        objet.completerInitialize()
        return objet
    end


    private_class_method :new
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

    #termine la creation d'un arrete en creant son tableau de case parcouru et en se placant dans les tableau necessaire
    #(contenu des cases parcourue et tableau d'arrete des sommets)
    def completerInitialize()
        plusX = @sommet1.position.x - @sommet2.position.x == 0 ? 0 : 1
        plusY = @sommet1.position.y - @sommet2.position.y == 0 ? 0 : 1

        laMatrice = @sommet1.position.grille.table
        caseAct = laMatrice[@sommet1.position.x + plusX, @sommet1.position.y + plusY]
        loop do
                @listeCase.push(caseAct)
                caseAct.contenu = self
                caseAct = laMatrice[caseAct.x + plusX, caseAct.y + plusY]
            break if caseAct.contenu == @sommet2
        end
        @sommet1.ajouterArete(self)
        @sommet2.ajouterArete(self)
        @sommet1.position.grille.addArete(self)
    end

    #recupere la taille de l'arrete (nombre de case parcourue)
    def getTaille()
        return listeCase.length()
    end

    #renvoie le sommet1 de l'arrete
    def getSommet1()
        return @sommet1
    end

    #renvoie le sommet2 de l'arrete
    def getSommet2()
        return @sommet2
    end

    #donne la liste de case de l'arrete
    def getListeCase()
      return @listeCase
    end

    #renvoie si l'arete est double ou non
    def estDouble()
        return @estDouble
    end

    def setDouble(condition)
        @estDouble = condition
    end

    #supprime proprement l'arrete
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
