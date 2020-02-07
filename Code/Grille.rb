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
        @table = Matrix.build(@longeur, @largeur){|row, col| Case.new(row, col, self)}
        @sommet = []
    end

    def addSommet(sommet)
        @sommet = @sommet + [sommet]
    end

end
