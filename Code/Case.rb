class Case

    attr_accessor :x, :y, :grille, :contenu
    attr_reader :surbrillance
    def initialize(x, y)
        @x = x
        @y = y
        @grille = nil
        @contenu = nil
        @surbrillance = false
    end

    #defini la case a laquelle appartient la case
    def setGrille(grille)
        @grille = grille
    end

    #defini la case a laquelle appartient la case
    def setSurbri(condition)
        @surbrillance = condition
    end

    #ajoute un objet en contenu de la case
    def ajouterContenu(objet)
        @contenu = objet
    end

    #teste si la case a des voisins
    def aSommetVoisin()
        if(@grille != nil)
            #puts "dimension de la grille : " + @grille.longueur.to_s + ":" + @grille.largeur.to_s
            #puts "test du voisin gauche, y = " + y.to_s
            boolSommetGauche = y-1 >= 0 ? @grille.getCase(x, y-1).contenu.is_a?(Sommet) : false
            #puts "test du voisin droit, y = " + y.to_s
            boolSommetDroit = y+1 < @grille.largeur ? @grille.getCase(x, y+1).contenu.is_a?(Sommet) : false
            #puts "test du voisin haut, x = " + x.to_s
            boolSommetHaut = x-1 >= 0 ? @grille.getCase(x-1, y).contenu.is_a?(Sommet) : false
            #puts "test du voisin bas, x = " + x.to_s
            boolSommetBas = x+1 < @grille.longueur ? @grille.getCase(x+1, y).contenu.is_a?(Sommet) : false
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
