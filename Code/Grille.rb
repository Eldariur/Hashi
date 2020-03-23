require "matrix"

#Classe permettant de définir une Grille
class Grille

  ## Partie variables d'instance

  #@longueur	-> Longueur de la grille (0->X)
  #@largeur		-> Largeur de la grille (0vY)
  #@table		-> La matrice des Case de la grille
  #@sommets		-> Le Tableau des sommets de la grille
  #@aretes		-> Le Tableau des aretes de la grille
  #@undo -> Pile de mouvement.

  #Creer un objet Grille proprement
  def self.creer(longueur, largeur)
      objet = new(longueur, largeur)
      objet.completerInitialize()
      return objet
  end

  #privatise le new
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
    @undo = Undo.creer()
  end

  ## Partie accesseurs

  # Accesseur get et set sur l'attribut table
  attr_accessor :table, :sommets, :longueur, :largeur, :aretes, :undo

  ## Partie méthodes

  #Complete le initialize
  #ajoute self comme grille des cases de la matrice
  def completerInitialize()
    for i in 0...@longueur do
      for j in 0...@largeur do
        @table[i, j].grille = self
      end
    end
  end

  ##Donne la case en x, y
  #
  # === Paramètre
  #
  # * +x+ : Le x de la case a obtenir
  # * +y+ : Le y de la case a obtenir
  #
  # === Return
  #
  # La case en (x, y)
  def getCase(x, y)
      return @table[x, y]
  end

  ##Ajoute un sommet a la liste des sommets
  #
  # === Parametre
  #
  # * +sommet+ : Le sommet a ajouter
  def addSommet(sommet)
      @sommets.push(sommet)
  end

  ##Ajoute une arete a la liste des sommets
  #
  # === Parametre
  #
  # * +arete+ : L'arete a ajouter
  def addArete(arete)
      @aretes.push(arete)
  end

  ##Retire un sommet a la liste des sommets
  #
  # === Parametre
  #
  # * +sommet+ : Le sommet a retirer
  def retirerSommet(sommet)
      @sommets.delete(sommet)
  end

  ##Retire une arete a la liste des sommets
  #
  # === Parametre
  #
  # * +sommet+ : L'arete a retirer
  def retirerArete(arete)
      @aretes.delete(arete)
  end

  ##Supprime toute les arete de la grille
  #Appele la methode supprimer() de chaque arete
  def clearAretes()
      laTaille = @aretes.size()
      for i in 0...laTaille do
          @aretes[0].supprimer()
      end
  end

  ##Réinistialise tous les sommets de la grille
  def clearSommets()
    @sommets.each do |s|
      s.complet = false
    end
  end

	#Donne la case suivante dans la direction donné
	#
	# === Paramètres
	#
	# * +lacase+ : La case d'ou partir
	# * +addX+ : la valeur a ajouter aux X
	# * +addY+ : la valeur a ajouter aux Y
	#
	# === Return
	#
	# La case suivante en partant de la case donné dans la direction donné
	def caseSuivante(lacase, addX, addY)
		leX = lacase.x
		leY = lacase.y
		if leX + addX >= @longueur|| leY + addY >= @largeur || leX + addX < 0|| leY + addY < 0
		    return nil
		end
		return getCase(leX + addX, leY + addY)

	end

	##Compte le nombre d'arete simple
	#
	# === Return
	#
	# * +nbSimple+ : Le nombre d'arete simple
	def nbAreteSimple
		nbSimple = 0
		@aretes.each { |x|
		    x.estDouble == false ? nbSimple += 1 : false
		}
		return nbSimple
	end

	##Compte le nombre d'arete double
	#
	# === Return
	#
	# * +nbSimple+ : Le nombre d'arete double
	def nbAreteDouble
		nbDouble = 0
		@aretes.each { |x|
		    x.estDouble ? nbDouble += 1 : false
		}
		return nbDouble
	end

	##Converti la Grille en chaine de charactere
	#
	# === Return
	#
	# * +s+ : La chaine de charactere correspondant a la grille
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

  ##Affiche la grille, case par case
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

	##Affiche la proportion d'arete simple et double par rapport au nombre d'arete
  def afficherProportionsAretes
    puts "Nombre d'arêtes : "+@aretes.size().to_s+".\nArêtes simples : "+self.nbAreteSimple().to_s+".\nArêtes double : "+self.nbAreteDouble().to_s+"\nPorpotions : "+(self.nbAreteSimple().to_f / (self.nbAreteSimple() + self.nbAreteDouble()) * 100).round(2).to_s+"% d'aretes simple."
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

 # Renvoie le nombre de sommets dans la grille.
  # === Return
  # * +@sommets.count()+ : @sommets.count() Le nombre de sommets dans la grille.
  def nbSommets()
    return @sommets.count()
  end

  # Cette methode calcule si deux sommets sont une arete de la grille.
  # === Return
  # * +boolean+ : boolean Le resultat de l'evaluation.
  def estArete(s1,s2)
    @aretes.each do |a|
      if((a.sommet1 == s1 && a.sommet2 == s2) || (a.sommet1 == s2 && a.sommet2 == s1))
        return true
      end
    end
    return false
  end

end
