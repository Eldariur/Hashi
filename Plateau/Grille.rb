require "matrix"

#Classe permettant de définir une Grille
class Grille

  ## Partie variables d'instance

  #@longueur	-> Longueur de la grille (0->X)
  #@largeur		-> Largeur de la grille (0vY)
  #@table		-> La matrice des Case de la grille
  #@sommets		-> Le Tableau des sommets de la grille
  #@aretes		-> Le Tableau des arêtes de la grille
  #@undo -> Pile de mouvement.

  #Créer un objet Grille proprement
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

  #Complète le initialize
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
  # * +x+ : Le x de la case à obtenir
  # * +y+ : Le y de la case à obtenir
  #
  # === Return
  #
  # La case en (x, y)
  def getCase(x, y)
      return @table[x, y]
  end

  ##Ajoute un sommet à la liste des sommets
  #
  # === Parametre
  #
  # * +sommet+ : Le sommet à ajouter
  def addSommet(sommet)
      @sommets.push(sommet)
  end

  ##Ajoute une arête à la liste des sommets
  #
  # === Paramètres
  #
  # * +arete+ : L'arête à ajouter
  def addArete(arete)
      @aretes.push(arete)
  end

  ##Retire un sommet à la liste des sommets
  #
  # === Paramètres
  #
  # * +sommet+ : Le sommet à retirer
  def retirerSommet(sommet)
      @sommets.delete(sommet)
  end

  ##Retire une arête à la liste des sommets
  #
  # === Paramètres
  #
  # * +sommet+ : L'arête à retirer
  def retirerArete(arete)
      @aretes.delete(arete)
  end

  ##Supprime toutes les arêtes de la grille
  #Appel la méthode supprimer() de chaque arête
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

	#Donne la case suivante dans la direction donnée
	#
	# === Paramètres
	#
	# * +lacase+ : La case d'où partir
	# * +addX+ : la valeur à ajouter aux X
	# * +addY+ : la valeur à ajouter aux Y
	#
	# === Return
	#
	# La case suivante en partant de la case donnée dans la direction donnée
	def caseSuivante(lacase, addX, addY)
		leX = lacase.x
		leY = lacase.y
		if leX + addX >= @longueur|| leY + addY >= @largeur || leX + addX < 0|| leY + addY < 0
		    return nil
		end
		return getCase(leX + addX, leY + addY)

	end

	##Compte le nombre d'arête simple
	#
	# === Return
	#
	# * +nbSimple+ : Le nombre d'arête simple
	def nbAreteSimple
		nbSimple = 0
		@aretes.each { |x|
		    x.estDouble == false ? nbSimple += 1 : false
		}
		return nbSimple
	end

	##Compte le nombre d'arête double
	#
	# === Return
	#
	# * +nbSimple+ : Le nombre d'arête double
	def nbAreteDouble
		nbDouble = 0
		@aretes.each { |x|
		    x.estDouble ? nbDouble += 1 : false
		}
		return nbDouble
	end

	##Convertit la Grille en chaîne de caractère
	#
	# === Return
	#
	# * +s+ : La chaîne de caractère correspondant à la grille
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

	##Affiche la proportion d'arête simple et double par rapport au nombre d'arête
  def afficherProportionsAretes
    puts "Nombre d'arêtes : "+@aretes.size().to_s+".\nArêtes simples : "+self.nbAreteSimple().to_s+".\nArêtes double : "+self.nbAreteDouble().to_s+"\nPorpotions : "+(self.nbAreteSimple().to_f / (self.nbAreteSimple() + self.nbAreteDouble()) * 100).round(2).to_s+"% d'aretes simple."
  end

  # Cette méthode calcule si il y a un chemin hamiltonien dans la grille.
  # === Return
  # * +boolean+ : boolean Le résultat de l'evaluation.
  def estHamilton?()
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

  # Cette méthode calcule si deux sommets sont une arête de la grille.
  # === Return
  # * +boolean+ : boolean Le résultat de l'évaluation.
  def estArete(s1,s2)
    @aretes.each do |a|
      if((a.sommet1 == s1 && a.sommet2 == s2) || (a.sommet1 == s2 && a.sommet2 == s1))
        return true
      end
    end
    return false
  end

  ##Vérifie si la grille passée en paramètre possède des erreurs par rapport à la grille générée et compte les erreurs
  #
  # === Paramètres
  #
  # * +grille+ : la grille à vérifier
  #
  # === Return
  #
  # * +nbErreur+ : le nombre d'erreur
  def trouverErreurs(grille)
      objErreurs = []
      # if @estGenere && grilleIdentique(grille)
          for i in 0...grille.sommets.size()
              if @sommets[i].nbArete >= 1
                  @sommets[i].listeArete.each do |areteJeu|
                      #on récupère l'autre sommet de l'arête
                      autreSommet = @sommets[i].autreSommet(areteJeu)
                      #on récupère son index dans la liste des sommets de la grille
                      index = @sommets.find_index(autreSommet)
                      index = index == nil ? 0 : index
                      areteGene = grille.sommets[i].donneAreteAvec(grille.sommets[index])
                      if (areteGene != nil)
                          if (areteJeu.estDouble && !areteGene.estDouble)
                              @sommets[i].estErreur = true
                              areteJeu.estErreur = true
                              objErreurs.push(@sommets[i])
                          end
                      end
                      #on regarde si cette arête existe dans le grille originale
                      if !(grille.sommets[i].possedeAreteAvec(grille.sommets[index]))
                          @sommets[i].estErreur = true
                          areteJeu.estErreur = true
                          objErreurs.push(@sommets[i])
                      end
                  end
              end
          end
      # end
      return objErreurs
  end

end
