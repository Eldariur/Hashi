class Case

    attr_accessor :x, :y, :grille
    def initialize(x, y, grille, contenu=nil)
        @x = x
        @y = y
        @grille = grille
        @contenu = contenu
    end

    def ajouterContenu(objet)
        @contenu = objet
    end
end
