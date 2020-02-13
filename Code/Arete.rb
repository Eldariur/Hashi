
class Arete
    #@direction
    #@sommet1
    #@sommet2
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
    end

    def getTaille()
        return listeCase.length()
    end

    def getSommet1()
        return @sommet1
    end

    def getSommet2()
        return @sommet2
    end

    def supprimer()
        loop do
            break if @listeCase.length == 0
            laCase = @listeCase.shift()
            laCase.ajouterContenu(nil)
        end
        @sommet1.retirerArete(self)
        @sommet2.retirerArete(self)
    end
end
