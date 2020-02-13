class Sommet
    #@listArete
    attr_accessor :position
    def initialize(valeur, position)
        @valeur = valeur
        @position = position #la case dans lequel est le sommet
        @listArete = Array.new()
        @position.ajouterContenu(self)
    end

    def setValeur(valeur)
        @valeur = valeur        
    end
end
