#Class représentant un Sommet
class Sommet

	## Partie variables d'instance

    #@listeArete	-> Liste des Aretes du Sommet
    #@position		-> Case dans laquelle le sommet est placé
    #@valeur		-> Entier représentant la valeur du Sommet (nombre d'arete total)
    #@complet		-> Booleen qui défini si un sommet est complet ou non (toutes les aretes occupées)
    
    #creer un Sommet proprement
    def self.creer(valeur, position)
        objet = new(valeur, position)
        objet.completerInitialize()
        return objet
    end

    private_class_method :new
    
    ## Partie initialize

	# Initialisation de la classe Sommet
	#
	# === Paramètres
	#
	# * +valeur+ : Valeur du sommet (en général initialisé a 0)
	# * +position+ : Case ou est placé le sommet
    def initialize(valeur, position)
        @valeur = valeur
        @position = position #la case dans lequel est le sommet
        @listeArete = Array.new()
        @complet = false
    end
    
    ## Partie accesseurs

	#Accesseur en get et en set sur la position, le booleen complet et la valeur
	attr_accessor :position, :complet, :valeur
	#Accesseur en get sur la liste d'arete
    attr_reader :listeArete

	## Partie méthodes

	##Complete le initialize
    #s'ajoute comme contenu de la case dans laquelle il est et a la liste de sommet de la grille
    def completerInitialize()
        @position.contenu = self
        @position.grille.addSommet(self)
    end

    ##Compte le nombre d'arete
    #parcours toute les arete pour compter le nombre d'arete
    #
    # === Return
    #
    # * +total+ : Le nombre total d'arete liés au Sommet
    def compterArete()
        total = 0
        @listeArete.each{ |arete|
            total += arete.estDouble ? 2 : 1
        }
        return total
    end

    ##ajoute une arrete a la liste de ses arrete
    def ajouterArete(arete)
        @listeArete << (arete)
    end

    ##retire une arrete de la liste de ses arrete
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

    ## Méthode testant si une case possède un sommet
    #
    # === Return
    #
    # Une Array contenant la liste des voisins du sommet
    def getListeVoisins()
      voisins = Array.new()

      (@position.x - 1).downto(-1) do |i|
        caseCourante = @position.grille.getCase(i, @position.y)
        if(hasSommet(caseCourante))
          voisins.push(caseCourante.contenu)
          break
        end
      end

      (@position.y - 1).downto(-1) do |i|
        caseCourante = @position.grille.getCase(@position.x, i)
        if(hasSommet(caseCourante))
          voisins.push(caseCourante.contenu)
          break
        end
      end

      (@position.x + 1).upto(@position.grille.longueur) do |i|
        caseCourante = @position.grille.getCase(i, @position.y)
        if(hasSommet(caseCourante))
          voisins.push(caseCourante.contenu)
          break
        end
      end

      (@position.y + 1).upto(@position.grille.largeur) do |i|
        caseCourante = @position.grille.getCase(@position.x, i)
        if(hasSommet(caseCourante))
          voisins.push(caseCourante.contenu)
          break
        end
      end

      return voisins
    end

  	# Retourne les sommets adjacents au sommet.
  	# === Return
  	# * +res+ : res la liste des sommets adjacents au sommet.
  	def getVoisins()
  	  res = Array.new()
  	  self.getAretes.each do |a|
  	    if(a.sommet1 != self) then res.push(a.sommet1) end
  	    if(a.sommet2 != self) then res.push(a.sommet2) end
  	end
  	  return res
  	end


    ## Méthode testant si une case possède un sommet
    #
    # === Paramètres
    #
    # * +uneCase+ : Case à tester
    #
    # === Return
    #
    # true si la case possède un sommet, false sinon
    def hasSommet(uneCase)
      if(uneCase != nil)
        return uneCase.contenu.class == Sommet
      else
        return false
      end
    end

    def afficher()
        print(@valeur)
    end

    ## Méthode calculant le nombre d'arêtes restantes dont un sommet a besoin afin d'être complet
    #
    # === Return
    #
    # Le nombre d'arêtes restantes
    def connectionsRestantes()
      return @valeur - @listeArete.size()
    end

    ## Méthode permettant de vérifier si un sommet possède au moins une arête commune avec chacun de ses voisins
    #
    # === Return
    #
    # Retourne vrai si un sommet possède au moins une arête avec chacun de ses voisins, faux sinon
    def areteAvecChaqueVoisin()
      voisinsAreteCommune = Array.new()

      @listeArete.each_with_index do |x|
        if(self != x.sommet1)
          voisinsAreteCommune.push(x.sommet1)
        else
          voisinsAreteCommune.push(x.sommet2)
        end
      end
      return voisinsAreteCommune.uniq().size() == self.compterVoisins()
    end
end
