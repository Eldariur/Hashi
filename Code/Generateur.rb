require "matrix"

class Generateur
    #@longeur
    #@largeur
    #@grille
    #@sommets

    def initialize(longeur, largeur, densite)
        @longeur = longeur
        @largeur = largeur
        @sommets = Array.new()
        #(@longeur * @largeur) / (@sommets.length() + 1) * 100;
        @densite = densite
        @nbSommet = (@longeur * @largeur / @densite).ceil
        @grille = @grille.new(@longeur, @largeur)
        @grille.completerInitialize()
    end

    def getCase(x, y)
        return @grille[x][y]
    end

    def vider()
        for i in 0...@longeur do
            for j in 0...@largeur do
                @grille.table[i][j] = nil
            end
        end
    end

    def placerSommet()

    end

    def creeUnegrille(nbSommet)
        self.vider()
        tableauDeAdd = [[0,1],[0,-1],[1,0],[-1,0]]
        tableau = @grille.table
        sommetPlaces = 0
        posX = rand(0...@longeur)
        posY = rand(0...@largeur)
        while tableau[posX][posY].contenu != nil
            puts "pas trouve"
            posX = rand(0...@longeur)
            posY = rand(0...@largeur)
        end
        sommet = Sommet.new(nil, tableau[posX][posY])
        @sommets << sommet
        sommetPlaces += 1
        loop do
            indicSommet = rand(0...tableau.length)
            lesAdds = tableauDeAdd[rand(0...tableauDeAdd.length)]
            sommetChoisi = @sommets[indicSommet]
            unless ((sommetChoisi.position.x + 2 * lesAdds[0] >= @longeur || sommetChoisi.position.x + 2 * lesAdds[0] < 0) || (sommetChoisi.position.y + 2 * lesAdds[1] >= @largeur || sommetChoisi.position.y + 2 * lesAdds[1] < 0))
                caseChoisie = tableau[posX][posY]
                loop do
                    caseChoisie = tableau[caseChoisie.x + lesAdds[0]][caseChoisie.y + lesAdds[1]]
                    resRand = rand(2)
                    break if resRand == 0
                end
            end
            break if sommetPlaces == nbSommet
        end
    end
end
