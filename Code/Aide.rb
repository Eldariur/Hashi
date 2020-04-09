
# Classe représentant une aide
class Aide < Gtk::Label



  ## Partie variables d'instance

  # @id         -> Id de l'aide
  # @grille     -> Grille dans laquelle l'aide est utile
  # @penalite   -> Penalité engendrée par l'aide en secondes
  # @nb_voisins -> Nombre de voisins de chaque sommet de la grille
  # @position   -> Case concernée par l'aide

  def Aide.creer(grille)
    new(grille)
  end

  # privatise le new
  private_class_method :new



  ## Partie initialize

	# Initialisation de la classe Aide
	#
	# === Parametre
	#
	# * +id+ : Représente l'id correspondant à l'aide
  def initialize(grille)
    @grille = grille
    @nb_voisins = Array.new(@grille.sommets.size())
    @id = definirCas()
    @penalite = 0
    puts @id.to_s
    super(self.getMessageAide())
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
    @penalite = 10
   	file_data = File.read("#{$cheminRacineHashi}/Code/TexteAide.txt").split("/").join(":").split(":")
  	#puts file_data
  	affiche = false
  	file_data.each do |x|
  		if affiche
  			return x
  		elsif x == "\n" + @id.to_s()
  			affiche = true
  		end
    end
  end

  ## Méthode permettant
  #
  # === Return
  #
  # L'aide visuelle correspondant à l'id de l'aide appelante
  def getCaseAide()
    @penalite = 20
   	return @position
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
    elsif estCas3()
      return 3
    elsif estCas4()
      return 4
    elsif estCas5()
      return 5
    elsif estCas6()
      return 6
    elsif estCas7()
      return 7
    elsif estCas8()
      return 8
    elsif estCas9()
      return 9
    elsif estCas10()
      return 10
    elsif estCas11()
      return 11
    elsif estCas12()
      return 12
    elsif estCas13()
      return 13
    elsif estCas14()
      return 14
    elsif estCas15()
      return 15
    elsif estCas16()
      return 16
    elsif estCas17()
      return 17
    elsif estCas18()
      return 18
    else
      return 0
    end
  end

  ## Méthode testant si un cas 1 est présent dans la grille
  # Cas 1 : île avec une seule île voisine restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas1()
    @grille.sommets.each_with_index do |x, i|
      if @nb_voisins[i] == 1 && x.compterArete() != x.valeur
        @position = @grille.getCase(x.position.x, x.position.y)
        return true
      end
    end
    return false
  end


  ## Méthode testant si un cas 2 est présent dans la grille
  # Cas 2 : île avec une seule île voisine restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas2()
    @grille.sommets.each_with_index do |x, i|
      if x.compterVoisinsNonComplets() == 1 && x.compterArete() != x.valeur
        @position = @grille.getCase(x.position.x, x.position.y)
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 3 est présent dans la grille
  # Cas 3 : île à 8 restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas3()
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 8 && x.compterArete() != x.valeur
        @position = @grille.getCase(x.position.x, x.position.y)
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 4 est présent dans la grille
  # Cas 4 : île à 6 avec 3 îles voisines restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas4()
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 6 && @nb_voisins[i] == 3 && x.compterArete() != x.valeur
        @position = @grille.getCase(x.position.x, x.position.y)
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 5 est présent dans la grille
  # Cas 5 : île à 4 avec 2 îles voisines restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas5()
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 4 && @nb_voisins[i] == 2 && x.compterArete() != x.valeur
        @position = @grille.getCase(x.position.x, x.position.y)
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 6 est présent dans la grille
  # Cas 6 : île à 7 avec une île voisine à 1 restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas6()
    compteur = 0
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 7 && x.compterArete() != x.valeur
        x.getListeVoisins().each do |v|
          if v.valeur == 1 && v.connexionsRestantes != 0
            compteur += 1
          end
        end
        if compteur == 1
          @position = @grille.getCase(x.position.x, x.position.y)
          return true
        end
      end
    end
    return false
  end

  ## Méthode testant si un cas 7 est présent dans la grille
  # Cas 7 : île à 5 avec trois îles voisines dont une à 1 restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas7()
    compteur = 0
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 5 && @nb_voisins[i] == 3 && x.compterArete() != x.valeur
        puts "test"
        x.getListeVoisins().each do |v|
          if v.valeur == 1
            compteur += 1
          end
        end
        if compteur == 1
          @position = @grille.getCase(x.position.x, x.position.y)
          return true
        end
      end
    end
    return false
  end

  ## Méthode testant si un cas 8 est présent dans la grille
  # Cas 8 : île à 3 avec deux îles voisines dont une à 1 restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas8()
    compteur = 0
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 3 && @nb_voisins[i] == 2 && x.compterArete() != x.valeur
        x.getListeVoisins().each do |v|
          if v.valeur == 1 && v.connexionsRestantes != 0
            compteur += 1
          end
        end
        if compteur == 1
          @position = @grille.getCase(x.position.x, x.position.y)
          return true
        end
      end
    end
    return false
  end

  ## Méthode testant si un cas 9 est présent dans la grille
  # Cas 9 : île à 7 restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas9()
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 7 && !x.areteAvecChaqueVoisin()
        @position = @grille.getCase(x.position.x, x.position.y)
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 10 est présent dans la grille
  # Cas 10 : île à 5 avec trois îles voisines restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas10()
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 5 && @nb_voisins[i] == 3 && !x.areteAvecChaqueVoisin()
        @position = @grille.getCase(x.position.x, x.position.y)
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 11 est présent dans la grille
  # Cas 11 : île à 3 avec deux îles voisines restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas11()
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 3 && @nb_voisins[i] == 2 && !x.areteAvecChaqueVoisin()
        @position = @grille.getCase(x.position.x, x.position.y)
        return true
      end
    end
    return false
  end

  ## Méthode testant si un cas 12 est présent dans la grille
  # Cas 12 : île à 6 avec deux des îles voisines à 1
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas12()
    compteur = 0
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 6 &&  x.compterArete() != x.valeur
        x.getListeVoisins().each do |v|
          compteur = 0
          if v.valeur == 1
            compteur += 1
          end
        end
        if compteur == 2
          @position = @grille.getCase(x.position.x, x.position.y)
          return true
        end
      end
    end
    return false
  end

  ## Méthode testant si un cas 13 est présent dans la grille
  # Cas 13 : île à 4 avec deux des îles voisines à 1
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas13()
    compteur = 0
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 4 && @nb_voisins[i] == 3 && x.compterArete() != x.valeur
        x.getListeVoisins().each do |v|
          compteur = 0
          if v.valeur == 1
            compteur += 1
          end
        end
        if compteur == 2
          @position = @grille.getCase(x.position.x, x.position.y)
          return true
        end
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
  def estCas14()
    voisinDeux = false
    @grille.sommets.each_with_index do |x, i|
      if x.valeur == 2 && @nb_voisins[i] == 2 && x.compterArete() == 0
        x.getListeVoisins().each do |v|
          if v.valeur == 2
            @position = @grille.getCase(x.position.x, x.position.y)
            voisinDeux = true
          end
        end
      end
    end
    return voisinDeux
  end

  ## Méthode testant si un cas 15 est présent dans la grille
  # Cas 15 : île à 2 avec deux îles voisines dont une île à 1 restante
  # Cas 15 : île avec deux connexions restantes et deux îles voisines non reliées dont une île à 1 restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas15()
    voisinUn = false
    @grille.sommets.each_with_index do |x, i|
      if x.connexionsRestantes == 2 && x.compterVoisinsNonRelies() == 2 && x.compterVoisinsComplets() + x.compterVoisinsNonRelies() == x.compterVoisins()
        x.getListeVoisins().each do |v|
          if v.valeur == 1 && !(v.possedeAreteAvec(x))
            @position = @grille.getCase(x.position.x, x.position.y)
            voisinUn = true
          end
        end
      end
    end
    return voisinUn
  end

  ## Méthode testant si un cas 16 est présent dans la grille
  # Cas 16 : île avec suffisamment de connexion restantes pour être connectée avec toutes ses voisines restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas16()
    @grille.sommets.each_with_index do |x, i|
      if (x.compterVoisinsNonComplets() * 2) - 1 <= x.connexionsRestantes() && x.connexionsRestantes() > 0
        if !x.areteAvecChaqueVoisin()
          @position = @grille.getCase(x.position.x, x.position.y)
          return true
        end
      end
    end
    return false
  end

  ## Méthode testant si un cas 17 est présent dans la grille
  # Cas 17 : île avec autant de connexions restantes que de connexions possibles restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas17()
    @grille.sommets.each_with_index do |x, i|
      compteur = 0
      if x.connexionsRestantes() > 0
        x.getListeVoisinsNonComplets().each do |v|
          if x.possedeAreteAvec(v)
            if(x.donneAreteAvec(x).estDouble)
              compteur += 0
            else
              compteur += 1
            end
          else
            compteur += 2
          end
        end
        if compteur == x.connexionsRestantes()
          @position = @grille.getCase(x.position.x, x.position.y)
          return true
        end
      end
    end
    return false
  end

  ## ANCIENNE METHODE 18

  # Méthode testant si un cas 13 est présent dans la grille
  # Cas 13 : île à 1 avec n îles voisines dont n-1 îles à 1 restante
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  # def estCas13()
  #   compteur = 0
  #   @grille.sommets.each_with_index do |x, i|
  #     if x.valeur == 1 && x.compterArete() != x.valeur
  #       compteur = 0
  #       x.getListeVoisins().each do |v, j|
  #         if v.valeur == 1
  #           compteur += 1
  #         end
  #       end
  #       if compteur == @nb_voisins[i] - 1 && compteur != 0
  #         @position = @grille.getCase(x.position.x, x.position.y)
  #         return true
  #       end
  #     end
  #   end
  #   return false
  # end

  ## Méthode testant si un cas 18 est présent dans la grille
  # Cas 18 : île avec une seule possibilité de connexion sans isolation restante dans la grille
  #
  # === Return
  #
  # true si le cas est vérifié pour un des sommets de la grille, false sinon
  def estCas18()
    @grille.sommets.each_with_index do |x, i|
      if x.connexionsRestantes() == 1
        nb_reliable = 0
        x.getListeVoisinsNonComplets().each do |v|
          reliable = false
          puts v.valeur.to_s
          if v.connexionsRestantes() > 1
            nb_reliable += 1
          end
          if v.connexionsRestantes() == 1
            traitement = Array.new()
            traites = Array.new()
            x.getVoisins().each do |c|
              if(c != v)
                traitement.push(c)
              end
            end
            v.getVoisins().each do |c|
              if(c != x)
                traitement.push(c)
              end
            end
            traites.push(x)
            traites.push(v)
            until traitement.empty?() || reliable == true
              traitement.each do |s|
                s.getVoisins().each do |c|
                  if(!traites.include?(c) && !traitement.include?(c))
                    traitement.push(c)
                  end
                end
                if s.complet
                  traitement.delete(s)
                  traites.push(s)
                else
                  reliable = true
                end
              end
            end
          end
          if reliable
            nb_reliable += 1
          end
        end
        if nb_reliable == 1
          @position = @grille.getCase(x.position.x, x.position.y)
          return true
        end
      end
    end
    return false
  end

end








#
