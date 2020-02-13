class Case

    attr_reader  :x, :y
    attr_accessor :grille, :contenu
    def initialize(x, y)
        @x = x
        @y = y
        @grille = nil
        @contenu = nil
    end

    def setGrille(grille)
        @grille = grille
    end

    def ajouterContenu(objet)
        @contenu = objet
    end

    def aSommetVoisin()
        return @grille.table[x+1,y].is_a?(Sommet) || @grille.table[x-1,y].is_a?(Sommet) || @grille.table[x,y+1].is_a?(Sommet) || @grille.table[x,y-1].is_a?(Sommet)
    end
end
