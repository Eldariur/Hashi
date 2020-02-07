require "matrix"

class Grille
    #@longeur
    #@largeur
    #@table
    #@sommets
    attr_accessor :table
    def initialize(longeur, largeur)
        @longeur = longeur
        @largeur = largeur
        @table = Matrix.build(@longeur, @largeur){|row, col| Case.new(row, col)}
        @sommets = []
        @aretes = []
    end

    def completerInitialize()
        for i in 0...@longeur do
            for j in 0...@largeur do
                @table[i, j].setGrille(self)
            end
        end
    end

    def addSommet(sommet)
        @sommet = @sommet + [sommet]
    end

end
