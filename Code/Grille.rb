require "matrix"

# Classe représentant uen grille de jeu
class Grille



  ## Partie variables d'instances

  # @longueur
  # @largeur
  # @table
  # @sommets

  #Creer un objet Grille proprement
  def creer(longueur, largeur)
    objet = new(longueur, largeur)
    objet.completerInitialize()
    return objet
  end

  #privatise le new et completerInitialize
  private_class_method :new, :completerInitialize

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
    @table = Matrix.build(@longueur, @largeur){|row, col| Case.creer(row, col)}
    @sommets = Array.new()
    @aretes = Array.new()
  end



  ## Partie accesseurs

  # Accesseur get sur l'attribut case
  attr_reader :case

  # Accesseur get et set sur l'attribut table
  attr_accessor :table



  # Partie méthodes

  #Complete le initialize
  #ajoute self comme grille des cases de la matrice
  def completerInitialize()
    for i in 0...@longueur do
      for j in 0...@largeur do
        @table[i, j].setGrille(self)
      end
    end
  end

  #recreer la matrice de case, puis appelle le completer initiliaze pour finir le boulot
  def vider()
    @table = Matrix.build(@longueur, @largeur){|row, col| Case.creer(row, col)}
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
