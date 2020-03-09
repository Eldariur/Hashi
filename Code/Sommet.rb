class Sommet
    #@listArete
    #@position
    #@valeur
    attr_accessor :position
    attr_reader :valeur, :listeArete, :complet
    #creer un Sommet proprement
    def self.creer(valeur, position)
        objet = new(valeur, position)
        objet.completerInitialize()
        return objet
    end

    private_class_method :new
    def initialize(valeur, position)
        @valeur = valeur
        @position = position #la case dans lequel est le sommet
        @listeArete = Array.new()
        @complet = false
    end

    #ajoute self comme contenu de la case a laquelle il est et a la liste de sommet de la grille
    def completerInitialize()
        @position.ajouterContenu(self)
        @position.grille.addSommet(self)
    end

    #defini la valeur du sommet
    def setValeur(valeur)
        @valeur = valeur
    end

    #defini si un sommet est complet ou non
    def setComplet(condition)
        @complet = condition
    end

    #compte le nombre d'aretes
    def compterArete()
        total = 0
        @listeArete.each{ |arete|
            total += arete.estDouble ? 2 : 1
        }
        return total
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
        print("O")
    end
end
