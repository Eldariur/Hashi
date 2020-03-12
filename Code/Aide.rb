
# Classe représentant une Aide
class Aide



  ## Partie variables d'instance

  # @id         -> Id de l'aide
  # @grille     -> Grille dans laquelle l'aide est utile
  # @penalite   -> Penalité engendrée par l'aide en secondes
  # @nb_voisins -> Nombre de voisins de chaque sommet de la grille

  def Aide.creer(grille)
    new(grille)
  end

  # privatise le new
  private_class_method :new



  ## Partie initialize

	# Initialisation de la class Aide
	#
	# === Parametre
	#
	# * +id+ : Représente l'id correspondant à l'aide
  def initialize(grille)
    @grille = grille
    @nb_voisins = Array.new(@grille.sommets.size())
    @id = definirCas()
  end



  ## Partie méthodes

  ## Méthode sans paramètres renvoyant l'id de l'aide correspondant au cas le plus simple présent dans la grille
  #
  # === Return
  #
	# * +id+ : Id de l'aide
  def afficherId()
    puts @id
  end

  ## Méthode permettant
  #
  # === Return
  #
  # L'aide textuelle correspondant à l'id de l'aide appelante
  def getMessageAide()
   	file_data = File.read("TexteAide.txt").split("\n").join(":").split(":")
  	#puts file_data
  	affiche = false
  	file_data.each do |x|
  		if affiche
  			return x
  		elsif x == @id.to_s()
  			affiche = true
  		end
    end
  end

  ## Méthode sans paramètres renvoyant l'id de l'aide correspondant au cas le plus simple présent dans la grille
  #
  # === Return
  #
	# * +id+ : Id de l'aide
  def definirCas()
    @grille.sommets.each_with_index do |x, i|
      @nb_voisins[i] = x.compterVoisins()
    end

    @grille.sommets.each_with_index do |x, i|
      if x.compterArete() != x.valeur
        if estCas1(x)
          return 1
        elsif estCas2(x, i)
          return 2
        elsif estCas3(x, i)
          return 3
        elsif estCas4(i)
          return 4
        elsif estCas5(x)
          return 5
        elsif estCas6(x, i)
          return 6
        elsif estCas7(x, i)
          return 7
        elsif estCas8(x)
          return 8
        elsif estCas9(x, i)
          return 9
        elsif estCas10(x, i)
          return 10
        elsif estCas11(x)
          return 11
        elsif estCas12(x, i)
          return 12
        elsif estCas13(x, i)
          return 13
        elsif estCas14(x)
          return 14
        # elsif estCas15(x.valeur)
        #   return 15
        # elsif estCas16(x.valeur)
        #   return 16
        else
          return 0
        end
      end
    end
  end

  ## Méthode testant si un cas 1 est présent dans la grille
  # Cas 1 : île à 8 restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas1(x)
    if x.valeur == 8
      return true
    end
    return false
  end

  ## Méthode testant si un cas 2 est présent dans la grille
  # Cas 2 : île à 6 avec 3 îles voisines restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas2(x, i)
    if x.valeur == 6 && @nb_voisins[i] == 3
      return true
    end
    return false
  end

  ## Méthode testant si un cas 3 est présent dans la grille
  # Cas 3 : île à 4 avec 2 îles voisines restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas3(x, i)
    if x.valeur == 4 && @nb_voisins[i] == 2
      return true
    end
    return false
  end

  ## Méthode testant si un cas 4 est présent dans la grille
  # Cas 4 : île avec une seule île voisine restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas4(i)
    if @nb_voisins[i] == 1
      return true
    end
    return false
  end

  ## Méthode testant si un cas 5 est présent dans la grille
  # Cas 5 : île à 7 avec une île voisine à 1 restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas5(x)
    compteur = 0
    if x.valeur == 7
      x.getListeVoisins().each do |v|
        if v.valeur == 1
          compteur += 1
        end
      end
      if compteur == 1
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 6 est présent dans la grille
  # Cas 6 : île à 5 avec trois îles voisines dont une à 1 restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas6(x, i)
    compteur = 0
    if x.valeur == 5 && @nb_voisins[i] == 3
      x.getListeVoisins().each do |v|
        if v.valeur == 1
          compteur += 1
        end
      end
      if compteur == 1
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 7 est présent dans la grille
  # Cas 7 : île à 3 avec deux îles voisines dont une à 1 restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas7(x, i)
    compteur = 0
    if x.valeur == 3 && @nb_voisins[i] == 2
      x.getListeVoisins().each do |v|
        if v.valeur == 1
          compteur += 1
        end
      end
      if compteur == 1
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 8 est présent dans la grille
  # Cas 8 : île à 7 restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas8(x)
    if x.valeur == 7
      return true
    end
    return false
  end

  ## Méthode testant si un cas 9 est présent dans la grille
  # Cas 9 : île à 5 avec trois îles voisines restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas9(x, i)
    if x.valeur == 5 && @nb_voisins[i] == 3
      return true
    end
    return false
  end

  ## Méthode testant si un cas 10 est présent dans la grille
  # Cas 10 : île à 3 avec deux îles voisines restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas10(x, i)
    if x.valeur == 3 && @nb_voisins[i] == 2
      return true
    end
    return false
  end

  ## Méthode testant si un cas 11 est présent dans la grille
  # Cas 11 : île à 6 avec deux des îles voisines à 1
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas11(x)
    compteur = 0
    if x.valeur == 6
      x.getListeVoisins().each do |v|
        if v.valeur == 1
          compteur += 1
        end
      end
      if compteur == 2
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 12 est présent dans la grille
  # Cas 12 : île à 4 avec deux des îles voisines à 1
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas12(x, i)
    compteur = 0
    if x.valeur == 4 && @nb_voisins[i] == 3
      x.getListeVoisins().each do |v|
        if v.valeur == 1
          compteur += 1
        end
      end
      if compteur == 2
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 13 est présent dans la grille
  # Cas 13 : île à 1 avec n îles voisines dont n-1 îles à 1 restantes
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas13(x, i)
    compteur = 0
    if x.connectionsRestantes == 1
      x.getListeVoisins().each do |v|
        if v.valeur == 1
          compteur += 1
        end
      end
      if compteur == @nb_voisins[i] - 1 && compteur != 0
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 14 est présent dans la grille
  # Cas 14 : île à 2 avec deux îles voisines dont une île à 2 restante
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas14(x)
    voisinDeux = false
    if x.connectionsRestantes() == 2 && x.compterVoisins() == 2
      x.getListeVoisins().each do |v|
        if v.valeur == 2
          voisinDeux = true
        end
      end
    end
    return voisinDeux
  end

  ## Méthode testant si un cas 15 est présent dans la grille
  # Cas 15 :
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas15(x)

  end



end








#
