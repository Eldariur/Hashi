# Cette classe represente une arete.
class Arete
  #@sommet1 -> le sommet 1.
  #@sommet2 -> Le sommet 2.
  #@estDouble -> Si une arete est double.

  # Accesseur get sur l'attribut sommet1.
  attr:sommet1, false
  # Accesseur get sur l'attribut sommet2.
  attr:sommet2, false
  # Accesseur get sur l'attribut estDouble.
  attr:estDouble, false

  # Cette methode creer une arete.
  # === Parametre
  # * +sommet1+ : sommet1 Le sommet n°1.
	# * +sommet2+ : sommet2 Le sommet n°2.
	# * +estDouble+ : estDouble Si l'arete est double ou non.
  # === Return
  # * +objet+ : objet La nouvelle arete.
  def self.creer(sommet1, sommet2, estDouble=false)
    objet = new(sommet1, sommet2, estDouble)
    objet.completerInitialize()
    return objet
  end

  # Privatise le new.
  private_class_method :new

  # Initialisation de la class Arete.
	# === Parametre
	# * +sommet1+ : sommet1 Le sommet n°1.
	# * +sommet2+ : sommet2 Le sommet n°2.
	# * +estDouble+ : estDouble Si l'arete est double ou non.
  def initialize(sommet1, sommet2, estDouble=false)
    @sommet1 = sommet1
    @sommet2 = sommet2
    @estDouble = estDouble
    @listeCase = Array.new()

    # Vérifie si le sommet1 est bien le plus en haut/a gauche, si c'est pas le cas, on échange les sommet1 et 2.
    if(sommet1.position.x > sommet2.position.x || sommet1.position.y > sommet2.position.y)
      sommetMem = @sommet1
      @sommet1 = sommet2
      @sommet2 = sommetMem
    end
  end

  # Termine la creation d'un arete en creant son tableau de cases parcourus et en se placant dans les tableaux necessaires.
  def completerInitialize()
    plusX = @sommet1.position.x - @sommet2.position.x == 0 ? 0 : 1
    plusY = @sommet1.position.y - @sommet2.position.y == 0 ? 0 : 1

    laMatrice = @sommet1.position.grille.table
    caseAct = laMatrice[@sommet1.position.x + plusX, @sommet1.position.y + plusY]
    loop do
      @listeCase.push(caseAct)
      caseAct.contenu = self
      caseAct = laMatrice[caseAct.x + plusX, caseAct.y + plusY]
      break if caseAct.contenu == @sommet2
    end
    @sommet1.ajouterArete(self)
    @sommet2.ajouterArete(self)
    @sommet1.position.grille.addArete(self)
  end

  # Recupere la taille de l'arete (nombre de cases parcourues).
  # === Return
  # * +listeCase.length()+ : listeCase.length() La taille de l'arete.
  def getTaille()
      return listeCase.length()
  end

  # Renvoie le sommet1 de l'arete.
  # === Return
  # * +@sommet1+ : @sommet1 Le sommet n°1.
  def getSommet1()
      return @sommet1
  end

  # Renvoie le sommet2 de l'arete.
  # === Return
  # * +@sommet2+ : @sommet2 Le sommet n°2.
  def getSommet2()
      return @sommet2
  end

  # Donne la liste de case de l'arete.
  # === Return
  # * +@listeCase+ : @listeCase La liste de case.
  def getListeCase()
    return @listeCase
  end

  # Renvoie si l'arete est double ou non.
  # === Return
  # * +@estDouble+ : @estDouble Un boolean qui represente si l'arete est double.
  def estDouble()
      return @estDouble
  end

  # Supprime une arete.
  def supprimer()
    loop do
      break if @listeCase.length == 0
      laCase = @listeCase.shift()
      laCase.ajouterContenu(nil)
    end
    @sommet1.position.grille.retirerArete(self)
    @sommet1.retirerArete(self)
    @sommet2.retirerArete(self)
  end

  # Affiche une arete.
  def afficher()
    if(@sommet1.position.x==@sommet2.position.x)
      if(@estDouble)
        print("=")
      else
        print("-")
      end
    else
      if(@estDouble)
        print("‖")
      else
        print("|")
      end
    end
  end

	# Cette methode redefini to_s pour afficher une arete.
  def to_s
      "Arete : Sommet1 = #{@sommet1}, Sommet2 = #{@sommet2}, estDouble? = #{@estDouble}\n"
  end
end
