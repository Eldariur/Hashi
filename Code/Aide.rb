
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

  def afficherId()
    puts @id
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

    if estCas1()
      return 1
    elsif estCas2()
      return 2
    # elsif estCas3()
    #   return 3
    # elsif estCas4()
    #   return 4
    # elsif estCas5()
    #   return 5
    # elsif estCas6()
    #   return 6
    # elsif estCas7()
    #   return 7
    # elsif estCas8()
    #   return 8
    # elsif estCas9()
    #   return 9
    # elsif estCas10()
    #   return 10
    # elsif estCas11()
    #   return 11
    # elsif estCas12()
    #   return 12
    # elsif estCas13()
    #   return 13
    # elsif estCas14()
    #   return 14
    # elsif estCas15()
    #   return 15
    # elsif estCas16()
    #   return 16
    else
      return 0
    end
  end

  ## Méthode testant si un cas 1 est présent dans la grille
  # Cas 1 : île à 8 restante dans la grille
  def estCas1()
    @grille.sommets.each do |x|
      if x.valeur == 8
        return true
      end
    end
    return false
  end

  def estCas2()
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 6 && @nb_voisins[i] == 3
        return true
      end
    end
    return false
  end

  #def estCas3()
  #
  #end

end








#
