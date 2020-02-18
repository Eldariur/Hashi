class Sommet
    #@listArete
    attr_accessor :position
    private_class_method :new, :completerInitialize
    def initialize(valeur, position)
        @valeur = valeur
        @position = position #la case dans lequel est le sommet
        @listeArete = Array.new()
    end

    #ajoute self comme contenu de la case a laquelle il est et a la liste de sommet de la grille
    def completerInitialize()
        @position.ajouterContenu(self)
        @position.grille.addSommet(self)
    end

    #creer un Sommet proprement
    def creer(valeur, position)
        objet = new(valeur, position)
        objet.completerInitialize()
        return objet
    end

    #defini la valeur du sommet
    def setValeur(valeur)
        @valeur = valeur
    end

    #ajoute une arrete a la liste de ses arrete
    def ajouterArete(arete)
        @listeArete << (arete)
    end

    #retire une arrete de la liste de ses arrete
    def retirerArete(arete)
        @listeArete.delete(arete)
    end

    def afficher()
        print(@valeur)
    end
end
