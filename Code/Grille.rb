require "matrix"

class Grille
  #@longueur
  #@largeur
  #@table
  #@sommets
  attr_accessor :table
  def initialize(longueur, largeur)
    @longueur = longueur
    @largeur = largeur
    @table = Matrix.build(@longueur, @largeur){|row, col| Case.new(row, col)}
    @sommets = Array.new()
    @aretes = Array.new()
  end

  def completerInitialize()
    for i in 0...@longueur do
      for j in 0...@largeur do
        @table[i, j].setGrille(self)
      end
    end
  end

  def getCase(x, y)
    return @table[x, y]
  end

  def addSommet(sommet)
    @sommets.push(sommet)
  end

  def addArete(arete)
    @aretes.push(arete)
  end

  def to_s()
    s = ""
    ajout = false
    0.upto(@longueur - 1) do |i|
      0.upto(@largeur - 1) do |j|
        @sommets.each do |x|
          if(x.getCase().x == i && x.getCase().y == j)
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
