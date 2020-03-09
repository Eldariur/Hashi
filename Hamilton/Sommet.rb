# Cette classe represente un sommet.
class Sommet
  #@listeArete -> Sa liste d'arete.
  #@position -> Sa position.
  #@valeur -> Sa valeur.

  # Accesseur get et set sur l'attribut position.
  attr_accessor :position
  # Accesseur get sur l'attribut valeur.
  attr_reader :valeur, :listeArete

  # Privatise le new.
  private_class_method :new

  # Creer un Sommet.
  # === Parametre
  # * +valeur+ : valeur La valeur du sommet.
  # * +position+ : position La position du sommet.
  def self.creer(valeur, position)
      objet = new(valeur, position)
      objet.completerInitialize()
      return objet
  end

  # Initialisation de la classe Sommet.
  # === Parametre
  # * +valeur+ : valeur La valeur du sommet.
  # * +position+ : position La position du sommet.
  def initialize(valeur, position)
      @valeur = valeur
      @position = position #la case dans lequel est le sommet
      @listeArete = Array.new()
  end

  # Ajoute self comme contenu de la case a laquelle il est et a la liste de sommet de la grille.
  def completerInitialize()
      @position.ajouterContenu(self)
      @position.grille.addSommet(self)
  end

  # Defini la valeur du sommet.
  # === Parametre
  # * +valeur+ : valeur La nouvelle valeur du sommet.
  def setValeur(valeur)
      @valeur = valeur
  end

  # Compte le nombre d'aretes.
  # === Return
  # * +total+ : total le nombre d'aretes.
  def compterArete()
      total = 0
      @listeArete.each{ |arete|
          total += arete.estDouble ? 2 : 1
      }
      return total
  end

  # Ajoute une arete a la liste de ses aretes.
  # === Parametre
  # * +arete+ : arete L'arete a ajouter.
  def ajouterArete(arete)
      @listeArete << (arete)
  end

  # Retire une arrete de la liste de ses aretes.
  # === Parametre
  # * +arete+ : arete L'arete a retirer.
  def retirerArete(arete)
      @listeArete.delete(arete)
  end

  # Retourne les aretes associes au sommet.
  # === Return
  # * +@listeArete+ : @listeArete Les aretes.
  def getAretes()
      return @listeArete
  end

  # Retourne les sommets adjacents au sommet.
  # === Return
  # * +res+ : res la liste des sommets adjacents au sommet.
  def getVoisins()
    res = Array.new()
    self.getAretes.each do |a|
      if(a.getSommet1() != self) then res.push(a.getSommet1()) end
      if(a.getSommet2() != self) then res.push(a.getSommet2()) end
    end
    return res
  end

	# Cette methode redefini to_s pour afficher un sommet.
  def to_s
    "#{@valeur}"
  end

  # Affiche un sommet.
  def afficher()
      print("O")
  end
end
