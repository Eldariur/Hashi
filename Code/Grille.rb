require "matrix"

class Grille



  ## Partie variables d'instance

  # @longueur
  # @largeur
  # @table
  # @sommets

  #Creer un objet Grille proprement
  def self.creer(longueur, largeur)
      objet = new(longueur, largeur)
      objet.completerInitialize()
      return objet
  end

  #privatise le new et completerInitialize
  private_class_method :new



  # Partie initialize

  # Initialisation de la classe Grille
  #
  # === Parametre
  #
  # * +longueur+ : Longueur de la grille (nombre de case)
  # * +largeur+ : Largeur de la grille (nombre de case)
  def initialize(longueur, largeur)
    @longueur = longueur
    @largeur = largeur
    @table = Matrix.build(@longueur, @largeur){|row, col| Case.new(row, col)}
    @sommets = Array.new()
    @aretes = Array.new()
  end



  ## Partie accesseurs

  # Accesseur get et set sur l'attribut table
  attr_accessor :table, :sommets



  ## Partie méthodes

  #Complete le initialize
  #ajoute self comme grille des cases de la matrice
  def completerInitialize()
    for i in 0...@longueur do
      for j in 0...@largeur do
        @table[i, j].setGrille(self)
      end
    end
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

  #retire une arrete de la liste de ses arrete
  def retirerSommet(sommet)
      @sommets.delete(sommet)
  end

  #retire une arrete de la liste de ses arrete
  def retirerArete(arete)
      @aretes.delete(arete)
  end

  #SUPPRIME TOUTE les aretes de la grille
  def clearAretes()
      @listeArete.each{ |arete|
          arete.supprimer()
      }
  end

  def to_s()
    s = ""
    ajout = false
    0.upto(@longueur - 1) do |i|
      0.upto(@largeur - 1) do |j|
        @sommets.each do |x|
          if(x.position.x == i && x.position.y == j)
             s += x.valeur.to_s()
             ajout = true
          end
        end
        @aretes.each do |x|
          #p x.getListeCase()
          x.getListeCase().each do |y|
            if(y.x == i && y.y == j)
              s += "|"
              ajout = true
            end
          end
        end
        if(ajout == false)
          s += "X"
        end
        ajout = false
      end
      s += "\n"
    end
    return s + "\n"
  end

  #affiche la grille, case par case
  def afficher()
     0.upto(@largeur + 1) do
       print("$")
     end
     print("\n$")
     @table.each{|c|
         if((c.y)+1 >= @largeur)
             c.afficher
             print("$\n$")
         else
             c.afficher
         end
     }
     0.upto(@largeur - 1) do
       print("$")
     end
     puts("$")
  end

end
