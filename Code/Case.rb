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
            boolSommetGauche = y-1 >= 0 && @grille.getCase(x, y-1).contenu.is_a?(Sommet)
            boolSommetDroit = y+1 < @grille.longueur && @grille.getCase(x, y+1).contenu.is_a?(Sommet)
            boolSommetHaut = y-1 >= 0 && @grille.getCase(x-1, y).contenu.is_a?(Sommet)
            boolSommetBas = x+1 < @grille.longueur && @grille.getCase(x+1, y).contenu.is_a?(Sommet)
            return boolSommetGauche || boolSommetDroit || boolSommetHaut || boolSommetBas
        else
            return false
        end
    end

    def estVoisin(caseTest)
        difX = @x - caseTest.x
        difY = @y - caseTest.y
        return difX.abs() == 1 || difY.abs() == 1
    end

    #teste si la case est vide
    def estVide()
      return @contenu==nil
    end

    def afficher()
       if(@contenu == nil)
           print(".")
       else
           @contenu.afficher()
       end
   end
end
