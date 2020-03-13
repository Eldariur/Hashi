require "matrix"

class Generateur
    #@longueur
    #@largeur
    #@grille
    #@sommets

    def initialize(difficulty, longueur=nil, largeur=nil, densite=nil)
        @chanceDeDouble = 38+rand(0..6)
        case difficulty
          when "easy"
            #Taille 7 à 14, densite 35 à 41
            @longueur = 7+rand(0..3)
            @largeur = 10+rand(0..4)
            @densite = 35+rand(0..6)
          when "normal"
            #Taille 8 à 14, densite 32 à 39
            @longueur = 8+rand(0..2)
            @largeur = 11+rand(0..3)
            @densite = 32+rand(0..7)
            @chanceDeDouble = 25+rand(0..9)
          when "hard"
            #Taille 9 à 14, densite 32 à 38
            @longueur = 9+rand(0..1)
            @largeur = 13+rand(0..1)
            @densite = 32+rand(0..6)
            @chanceDeDouble = 26+rand(0..2)
          else
            @longueur = longueur
            @largeur = largeur
            @densite = densite
        end
        @sommets = Array.new()
        #(@longueur * @largeur) / (@sommets.length() + 1) * 100;
        ##puts "longueur : " + @longueur.to_s
        ##puts "largeur : " + @largeur.to_s
        ##puts "densite : " + @densite.to_s
        ##puts "longueur*largeur.ceil : " + (((@longueur * @largeur).to_f / 100).ceil).to_s
        @nbSommet = (((@longueur * @largeur).to_f  / 100) * @densite).ceil
        ##puts "Dimensions : "+@longueur.to_s+"x"+@largeur.to_s+"("+(@largeur*@longueur).to_s+"cases). Nb sommets attendus "+@nbSommet.to_s+" pour une densite de "+@densite.to_s
        @grille = Grille.creer(@longueur, @largeur)
    end

    def getCase(x, y)
        return @grille[x][y]
    end

    def vider()
        @grille = Grille.creer(@longueur, @largeur)
    end

    def getGrilleSansArete()
        cloneGrille = Marshal.load(Marshal.dump(@grille))
        cloneGrille.clearAretes()
        return cloneGrille
    end

    def getGrilleAvecArete()
        return @grille
    end

    def placerLabelSommet()
        @sommets.each { |sommet|
            sommet.valeur = sommet.compterArete()
        }
    end

    #renvoie si la case passée en parametre + les coordonées du tableau passé en parametre sont dans la matrice
    def estDansMatrice(caseDeDepart, lesAdds)
        xDuSommet = caseDeDepart.x
        yDuSommet = caseDeDepart.y
        return (xDuSommet + lesAdds[0] < @longueur) && (xDuSommet + lesAdds[0] >= 0) && (yDuSommet + lesAdds[1] < @largeur) && (yDuSommet + lesAdds[1] >= 0)
    end

    def creeUneGrille(nbSommet=nil)
        if(nbSommet != nil)
          @nbSommet = nbSommet
        end
        self.vider()
        tableauDeAdd = [[0,1],[0,-1],[1,0],[-1,0]]
        sommetPlaces = 0

        coordXPremierSommet = rand(0...@longueur)
        coordYPremierSommet = rand(0...@largeur)
        sommetDeDepart = Sommet.creer(0, @grille.getCase(coordXPremierSommet, coordYPremierSommet))
        @sommets.push(sommetDeDepart)
        sommetPlaces += 1
        @grille.afficher()

        #boucle qui place des sommets
        nbCancel = 0
        loop {
            break if sommetPlaces >= @nbSommet || nbCancel > sommetPlaces
            puts "nbCancel : " + nbCancel.to_s() + "\nsommetsPlaces : " + sommetPlaces.to_s() + "\nnbSommets : " + @nbSommet.to_s()
            #puts "nbSommets : " + sommetPlaces.to_s + "/" + @nbSommet.to_s
            #on commence par choisir un sommet
            sommetAEtePlace = false
       		aEteCancel = false
            indiceSommetChoisi = rand(0...@sommets.size())
            sommetChoisi = @sommets[indiceSommetChoisi]
            xDuSommet = sommetChoisi.position.x
            yDuSommet = sommetChoisi.position.y

            #puts "on part du sommet " + indiceSommetChoisi.to_s + " en " + sommetChoisi.position.x.to_s + ":" + sommetChoisi.position.y.to_s

            #on choisi une direction
            #tant que la direction marche pas on continu d'en choisir une
            lesAdds = nil
            loop {
                indiceDirectionChoisie = rand(0...tableauDeAdd.size())
                lesAdds = tableauDeAdd[indiceDirectionChoisie]

                boolYaUneCaseDevant = estDansMatrice(sommetChoisi.position, lesAdds)
                boolYaUneCase2Devant = estDansMatrice(sommetChoisi.position, [lesAdds[0]*2, lesAdds[1]*2])
                break if boolYaUneCaseDevant && boolYaUneCase2Devant
            }
            #puts "direction choisie : " + lesAdds.to_s
            #break

            caseOuPlacer = @grille.getCase(xDuSommet + 2*lesAdds[0], yDuSommet + 2*lesAdds[1])
            #puts "on part de " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
            #puts "contenu de la case de depart : " + caseOuPlacer.contenu.class.to_s
            #on garde la case juste devant (celle entre sommetChoisi.position et caseOuPlacer) pour tester histoire de pas passer par desuus quelque chose
            caseEntreLesDeux = @grille.getCase(xDuSommet + lesAdds[0], yDuSommet + lesAdds[1])

            #si la case est vide alors on commence a essayer de placer
            #puts "Case Ou Placer avant if: " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
            if caseOuPlacer.estVide() && caseEntreLesDeux.estVide()
                #puts "Case Ou Placer après if: " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                sommetAEtePlace = false
                aEteCancel = false
                loop {
                    break if sommetAEtePlace || aEteCancel

                    #puts "Case Ou Placer : " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                    #puts "Contenu : " + caseOuPlacer.class.to_s

                    boolArretViaRand = rand(0..3) <= 2
                    boolSommetJusteDevant = estDansMatrice(caseOuPlacer, lesAdds) && @grille.caseSuivante(caseOuPlacer, lesAdds[0], lesAdds[1]).contenu.class == Sommet
                    boolAreteJusteDevant = estDansMatrice(caseOuPlacer, lesAdds) && @grille.caseSuivante(caseOuPlacer, lesAdds[0], lesAdds[1]).contenu.class == Arete
                    boolBordDuTableau = !(estDansMatrice(caseOuPlacer, lesAdds))

                    #si un seul des booleen est vrai
                    if boolArretViaRand || boolSommetJusteDevant || boolAreteJusteDevant || boolBordDuTableau
                        #on test les bool un par un

                        if boolSommetJusteDevant
                            #puts "Arret via sommet devant en " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                            #on recule jusqu'a trouver une case bien
                            while caseOuPlacer.aSommetVoisin()
                                caseOuPlacer = @grille.getCase(caseOuPlacer.x - lesAdds[0], caseOuPlacer.y - lesAdds[1])
                                break if caseOuPlacer == sommetChoisi.position || caseOuPlacer.estVoisin(sommetChoisi.position)
                            end

                            #on teste pourquoi on s'est arrete
                            if caseOuPlacer == sommetChoisi.position || caseOuPlacer.estVoisin(sommetChoisi.position)
                                aEteCancel = true
                            else
                                nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                @sommets.push(nouveauSommet)
                                sommetPlaces += 1

                                nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(1..100) < @chanceDeDouble)

                                sommetAEtePlace = true
                            end
                        elsif boolAreteJusteDevant
                            #puts "Arret via areteDevant en " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                            #si on peut placer sur l'arete on le fait, sinon on recul
                            caseDArete = @grille.getCase(caseOuPlacer.x + lesAdds[0], caseOuPlacer.y + lesAdds[1])
                            if !(caseDArete.aSommetVoisin()) && caseDArete.contenu.getTaille() >= 3
                                sommet1 = caseDArete.contenu.sommet1
                                sommet2 = caseDArete.contenu.sommet2
                                caseDArete.contenu.supprimer()

                                nouveauSommet = Sommet.creer(0, caseDArete)
                                @sommets.push(nouveauSommet)
                                sommetPlaces += 1

                                nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(1..100) < @chanceDeDouble)

                                sommetAEtePlace = true

                                nouvelleArete1 = Arete.creer(sommet1, nouveauSommet, rand(1..100) < @chanceDeDouble)
                                nouvelleArete2 = Arete.creer(sommet2, nouveauSommet, rand(1..100) < @chanceDeDouble)
                            else
                                #sinon on recule jusqu'a trouver un truc bien
                                while caseOuPlacer.aSommetVoisin()
                                    caseOuPlacer = @grille.getCase(caseOuPlacer.x - lesAdds[0], caseOuPlacer.y - lesAdds[1])
                                    break if caseOuPlacer == sommetChoisi.position || caseOuPlacer.estVoisin(sommetChoisi.position)
                                end

                                #on teste pourquoi on s'est arrete
                                if caseOuPlacer == sommetChoisi.position || caseOuPlacer.estVoisin(sommetChoisi.position)
                                    aEteCancel = true
                                else
                                    nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                    @sommets.push(nouveauSommet)
                                    sommetPlaces += 1

                                    nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(1..100) < @chanceDeDouble)

                                    sommetAEtePlace = true
                                end
                            end
                        elsif boolBordDuTableau
                            #puts "Arret via bord " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                            if !(caseOuPlacer.aSommetVoisin())
                                nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                #puts "sommet crée"
                                @sommets.push(nouveauSommet)
                                sommetPlaces += 1

                                nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(1..100) < @chanceDeDouble)

                                sommetAEtePlace = true
                            else
                                #sinon, on recule jusqu'a trouver un endroit bien
                                while caseOuPlacer.aSommetVoisin()
                                    caseOuPlacer = @grille.getCase(caseOuPlacer.x - lesAdds[0], caseOuPlacer.y - lesAdds[1])
                                    break if caseOuPlacer == sommetChoisi.position || caseOuPlacer.estVoisin(sommetChoisi.position)
                                end

                                #on teste pourquoi on s'est arrete
                                if caseOuPlacer == sommetChoisi.position || caseOuPlacer.estVoisin(sommetChoisi.position)
                                    aEteCancel = true
                                else
                                    nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                    #puts "sommet crée après recul en " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                                    @sommets.push(nouveauSommet)
                                    sommetPlaces += 1

                                    nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(1..100) < @chanceDeDouble)

                                    sommetAEtePlace = true
                                end
                            end
                        elsif boolArretViaRand
                            #puts "Arret via rand en " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                            #on verifie qu'il n'y a rien autour
                            if !(caseOuPlacer.aSommetVoisin())
                                nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                @sommets.push(nouveauSommet)
                                sommetPlaces += 1

                                nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(1..100) < @chanceDeDouble)

                                sommetAEtePlace = true
                            else
                                #sinon, on recule jusqu'a trouver un endroit bien
                                while caseOuPlacer.aSommetVoisin()
                                    caseOuPlacer = @grille.getCase(caseOuPlacer.x - lesAdds[0], caseOuPlacer.y - lesAdds[1])
                                    break if caseOuPlacer == sommetChoisi.position || caseOuPlacer.estVoisin(sommetChoisi.position)
                                end

                                #on teste pourquoi on s'est arrete
                                if caseOuPlacer == sommetChoisi.position || caseOuPlacer.estVoisin(sommetChoisi.position)
                                    aEteCancel = true
                                else
                                    nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                    @sommets.push(nouveauSommet)
                                    sommetPlaces += 1

                                    nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(1..100) < @chanceDeDouble)

                                    sommetAEtePlace = true
                                end
                            end
                        end
                    else
                        #si aucun arret est lancé, on avance juste
                        caseOuPlacer = @grille.caseSuivante(caseOuPlacer, lesAdds[0], lesAdds[1])
                        #puts "on a avancé"
                    end
                }
              	if sommetAEtePlace
              		nbCancel = 0
              	else
              		nbCancel +=1
              	end
            end 
            placerLabelSommet()
            @grille.afficher()
        }
        return getGrilleSansArete()
    end
end
