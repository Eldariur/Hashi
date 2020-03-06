require "matrix"

# Cette classe represente une grille.
class Grille
  #@longueur -> Sa longueur.
  #@largeur -> La largeur.
  #@table -> la matrice.
  #@sommets -> Sa liste de sommets.

  # Creer une grille.
  # === Parametre
  # * +longueur+ : Longueur de la grille (nombre de case).
  # * +largeur+ : Largeur de la grille (nombre de case).
  def self.creer(longueur, largeur)
      objet = new(longueur, largeur)
      objet.completerInitialize()
      return objet
  end

  # Privatise le new.
  private_class_method :new

  # Initialisation de la classe Grille.
  # === Parametre
  # * +longueur+ : Longueur de la grille (nombre de case).
  # * +largeur+ : Largeur de la grille (nombre de case).
  def initialize(longueur, largeur)
    @longueur = longueur
    @largeur = largeur
    @table = Matrix.build(@longueur, @largeur){|row, col| Case.new(row, col)}
    @sommets = Array.new()
    @aretes = Array.new()
  end

  # Accesseur get et set sur l'attribut table et sommets.
  attr_accessor :table, :sommets

  # Complete le initialize.
  def completerInitialize()
    for i in 0...@longueur do
      for j in 0...@largeur do
        @table[i, j].setGrille(self)
      end
    end
  end

  # Renvoie la case en x, y.
  # === Return
  # * +case+ : case La case correspondante.
  def getCase(x, y)
      return @table[x, y]
  end

  # Ajoute le sommet a la liste de sommet.
  def addSommet(sommet)
      @sommets.push(sommet)
  end

  # Ajoute l'arrete a la liste d'arete.
  def addArete(arete)
      @aretes.push(arete)
  end

  # Retire une arete de la liste de ses aretes.
  def retirerSommet(sommet)
      @sommets.delete(sommet)
  end

  # Retire une arete de la liste de ses aretes.
  def retirerArete(arete)
      @aretes.delete(arete)
  end

  #SUPPRIME TOUTES les aretes de la grille.
  def clearAretes()
      @listeArete.each{ |arete|
          arete.supprimer()
      }
  end

  # Renvoie le nombre de sommets dans la grille.
  # === Return
  # * +@sommets.count()+ : @sommets.count() Le nombre de sommets dans la grille.
  def nbSommets()
    return @sommets.count()
  end

  # Cette methode calcule si il y a un chemin hamiltonien dans la grille.
  # === Return
  # * +boolean+ : boolean Le resultat de l'evaluation.
  def testHamilton()
    marque = Hash.new(false)
    stack = Array.new()

    stack.push(@sommets.first)
    while !stack.empty? do
      temp = stack.shift
      temp.getVoisins().each do |v|
        if(marque[v] == false) then stack.push(v) end
      end
      marque[temp] = true
    end
    if(marque.count != self.nbSommets()) then return false
    else return true end
  end

	# Cette methode redefini to_s pour afficher une grille.
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

  # Affiche la grille.
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
