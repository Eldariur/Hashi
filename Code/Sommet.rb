class Sommet
    #@listArete
    attr_accessor :position, :valeur
    def initialize(valeur = 0, position)
        @valeur = valeur
        @position = position #la case dans lequel est le sommet
        @listeArete = Array.new()
        @position.ajouterContenu(self)
    end




    def getCase()
      return @position
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

    def afficher()
        print(@valeur)
    end

end
