class Sommet
    #@listArete
    #@position
    #@valeur
    attr_accessor :position
    attr_reader :valeur
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

    ## Méthode retournant le nombre de voisins d'un sommet
    #
    # === Return
    #
    # * +nb_voisins+ : Nombre de voisins du sommet
    def compterVoisins()
        nb_voisins = 0
        voisins = [false, false, false, false]

      @position.grille.sommets.each do |x|
        if @position.x > x.position.x && @position.y == x.position.y
          voisins[0] = true
        elsif @position.x < x.position.x && @position.y == x.position.y
          voisins[1] = true
        elsif @position.y > x.position.y && @position.x == x.position.x
          voisins[2] = true
        elsif @position.y < x.position.y && @position.x == x.position.x
          voisins[3] = true
        end
      end

        for bool in voisins
            if bool
                nb_voisins += 1
            end
        end

        return nb_voisins
    end

    def afficher()
        print(@valeur)
    end
end
