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
        tableau = @grille.table
        sommetPlaces = 0
        posX = rand(0...@longeur)
        posY = rand(0...@largeur)
        while tableau[posX][posY] != nil
            puts "pas trouve"
            posX = rand(0...@longeur)
            posY = rand(0...@largeur)
        end
        tableau[posX][posY] = Sommet.new(posX, posY)
        @sommets << tableau[posX][posY]
        sommetPlaces += 1
        loop do
            indicSommet = rand(0...tableau.length)
            indicCote = rand(0...4)
            sommetChoisi = @sommets[indicSommet]
            if !sommetChoisi.coteUtilise(indicCote)
                if self.placerSommet(indicCote, sommetChoisi) != nil

                end
            end
            break if @sommets.length() == nbSommet
        end
    end
end
