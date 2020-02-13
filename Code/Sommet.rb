class Sommet
    #@listArete
    attr_accessor :position, :valeur
    def initialize(valeur, position)
        @valeur = valeur
        @position = position #la case dans lequel est le sommet
        @listArete = Array.new()
        @position.ajouterContenu(self)
    end

<<<<<<< HEAD
    def getCase()
      return @position
=======
    def setValeur(valeur)
        @valeur = valeur
    end

    def ajouterArete(arete)
        @listeArete << (arete)
    end

    def retirerArete(arete)
        @listeArete.delete(arete)
>>>>>>> ebd2b951391f90bec8d678d55164d029a11fc29a
    end
end
