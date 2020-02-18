class Sommet
    #@listArete
    attr_accessor :position
    def initialize(valeur, position)
        @valeur = valeur
        @position = position #la case dans lequel est le sommet
        @listeArete = Array.new()
    end

    def completerInitialize()
        @position.ajouterContenu(self)
    end

    def setValeur(valeur)
        @valeur = valeur
    end

    def ajouterArete(arete)
        @listeArete << (arete)
    end

    def retirerArete(arete)
        @listeArete.delete(arete)
    end

    def afficheToi()
        print("O")
    end
end
