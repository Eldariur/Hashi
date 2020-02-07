class Case

    attr_accessor :x, :y, :grille, :contenu
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
end
