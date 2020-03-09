# Cette classe represente une case.
class Case
  #@x -> La coordonnees X.
  #@y -> La coordonnees Y.
  #@grille -> Sa grille.
  #@contenu -> Son contenu.

  # Accesseur get et set sur les attributs x, y, grille et contenu.
  attr_accessor :x, :y, :grille, :contenu

  # Initialisation de la class Case.
	# === Parametre
	# * +x+ : x La coordonnees X.
	# * +y+ : y Le coordonnees Y.
  def initialize(x, y)
      @x = x
      @y = y
      @grille = nil
      @contenu = nil
  end

  # Defini la case a laquelle appartient la case.
  # === Parametre
  # * +grille+ : grille La grille.
  def setGrille(grille)
      @grille = grille
  end

  # Ajoute un objet en contenu de la case.
  # === Parametre
  # * +objet+ : objet Le nouveau contenu.
  def ajouterContenu(objet)
      @contenu = objet
  end

  # Teste si la case a des voisins.
  # === Return
  # * +boolean+ : boolean Le resultat de l'evaluation.
  def aSommetVoisin()
      if(@grille != nil)
          return @grille.table[x+1,y].is_a?(Sommet) || @grille.table[x-1,y].is_a?(Sommet) || @grille.table[x,y+1].is_a?(Sommet) || @grille.table[x,y-1].is_a?(Sommet)
      else
          return false
      end
  end

  # Affiche une case.
  def afficher()
      if(@contenu == nil)
          print(".")
      else
          @contenu.afficher()
      end
  end
end
