class Case

    attr_accessor :x, :y, :grille, :contenu
    def initialize(x, y)
        @x = x
        @y = y
        @grille = nil
        @contenu = nil
    end

    #defini la case a laquelle appartient la case
    def setGrille(grille)
        @grille = grille
    end

    #ajoute un objet en contenu de la case
    def ajouterContenu(objet)
        @contenu = objet
    end

    #teste si la case a des voisins
    def aSommetVoisin()
        if(@grille != nil)
            return @grille.table[x+1,y].is_a?(Sommet) || @grille.table[x-1,y].is_a?(Sommet) || @grille.table[x,y+1].is_a?(Sommet) || @grille.table[x,y-1].is_a?(Sommet)
        else
            return false
        end
    end

    def afficher()
        if(@contenu == nil)
            print(".")
        else
            @contenu.afficher()
        end
    end
end
