
class Helper
    def initialize()

    end

    def newGrille(longueur, largeur)
        grille = Grille.new(longueur, largeur)
        grille.completerInitialize()
        return grille
    end

    def newArete(sommet1, sommet2, estDouble=false)
        arete = Grille.new(sommet1, sommet2, estDouble=false)
        arete.completerInitialize()
        return arete
    end

    def newSommet(valeur, position)
        sommet = Sommet.new(valeur, position)
        sommet.completerInitialize()
        return sommet
    end
end
