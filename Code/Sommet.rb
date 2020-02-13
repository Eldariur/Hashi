class Sommet
    #@listArete
    attr_accessor :position, :valeur
    def initialize(valeur, position)
        @valeur = valeur
        @position = position #la case dans lequel est le sommet
        @listArete = Array.new()
        @position.ajouterContenu(self)
    end

    def getCase()
      return @position
    end
end
