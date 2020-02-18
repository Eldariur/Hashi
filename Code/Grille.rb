require "matrix"

class Grille
    #@longueur
    #@largeur
    #@table
    #@sommets
    private_class_method :new
    attr_accessor :table

    def initialize(longueur, largeur)
        @longueur = longueur
        @largeur = largeur
        @table = Matrix.build(@longueur, @largeur){|row, col| Case.new(row, col)}
        @sommets = Array.new()
        @aretes = Array.new()
    end

    #Complete le initialize
    #ajoute self comme grille des cases de la matrice
    def completerInitialize()
        for i in 0...@longueur do
            for j in 0...@largeur do
                @table[i, j].setGrille(self)
            end
        end
    end

    #Creer un objet Grille proprement
    def self.creer(longueur, largeur)
        objet = new(longueur, largeur)
        objet.completerInitialize()
        return objet
    end

    #recreer la matrice de case, puis appelle le completer initiliaze pour finir le boulot
    def vider()
        @table = Matrix.build(@longueur, @largeur){|row, col| Case.new(row, col)}
        completerInitialize()
    end

    #renvoie la case en x, y
    def getCase(x, y)
        return @table[x, y]
    end

    #ajoute le sommet a la liste de sommet
    def addSommet(sommet)
        @sommets.push(sommet)
    end

    #ajoute l'arrete a la liste d'arrete
    def addArete(arete)
        @aretes.push(arete)
    end


    #affiche la grille, case par case
    def afficheToi()
        @table.each{|c|
            if((c.y)+1 >= @largeur)
                c.afficheToi
                puts("")
            else
                c.afficheToi
            end
        }
    end

end
