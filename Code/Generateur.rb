require "matrix"

class Generateur
    #@longueur
    #@largeur
    #@grille
    #@sommets

    def initialize(longueur, largeur, densite)
        @longueur = longueur
        @largeur = largeur
        @sommets = Array.new()
        #(@longueur * @largeur) / (@sommets.length() + 1) * 100;
        @densite = densite
        @nbSommet = (@longueur * @largeur / 100 * @densite).ceil
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
            sommet.setValeur(sommet.compterArete())
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
        loop {
            break if sommetPlaces >= nbSommet
            puts "nbSommets : " + sommetPlaces.to_s + "/" + nbSommet.to_s
            #on commence par choisir un sommet
            indiceSommetChoisi = rand(0...@sommets.size())
            sommetChoisi = @sommets[indiceSommetChoisi]
            xDuSommet = sommetChoisi.position.x
            yDuSommet = sommetChoisi.position.y

            puts "on part du sommet " + indiceSommetChoisi.to_s + " en " + sommetChoisi.position.x.to_s + ":" + sommetChoisi.position.y.to_s

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
            puts "direction choisie : " + lesAdds.to_s
            #break

            caseOuPlacer = @grille.getCase(xDuSommet + 2*lesAdds[0], yDuSommet + 2*lesAdds[1])
            puts "on part de " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
            puts "contenu de la case de depart : " + caseOuPlacer.contenu.class.to_s
            #on garde la case juste devant (celle entre sommetChoisi.position et caseOuPlacer) pour tester histoire de pas passer par desuus quelque chose
            caseEntreLesDeux = @grille.getCase(xDuSommet + lesAdds[0], yDuSommet + lesAdds[1])

            #si la case est vide alors on commence a essayer de placer
            puts "Case Ou Placer avant if: " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
            if caseOuPlacer.estVide() && caseEntreLesDeux.estVide()
                puts "Case Ou Placer après if: " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                sommetAEtePlace = false
                aEteCancel = false
                loop {
                    break if sommetAEtePlace || aEteCancel

                    puts "Case Ou Placer : " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s

                    boolArretViaRand = rand(0..1) == 1 #TODO
                    boolSommetJusteDevant = estDansMatrice(caseOuPlacer, lesAdds) && @grille.caseSuivante(caseOuPlacer, lesAdds[0], lesAdds[1]).class == Sommet
                    boolAreteJusteDevant = estDansMatrice(caseOuPlacer, lesAdds) && @grille.caseSuivante(caseOuPlacer, lesAdds[0], lesAdds[1]).class == Sommet
                    boolBordDuTableau = !(estDansMatrice(caseOuPlacer, lesAdds))

                    #si un seul des booleen est vrai
                    if boolArretViaRand || boolSommetJusteDevant || boolAreteJusteDevant || boolBordDuTableau
                        #on test les bool un par un

                        if boolSommetJusteDevant
                            puts "Arret via sommet devant en " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                            #on recule jusqu'a trouver une case bien
                            while caseOuPlacer.aSommetVoisin()
                                caseOuPlacer = @grille.getCase(caseOuPlacer.x - lesAdds[0], caseOuPlacer.y - lesAdds[1])
                                break if caseOuPlacer == sommetChoisi.position
                            end

                            #on teste pourquoi on s'est arrete
                            if caseOuPlacer == sommetChoisi.position
                                aEteCancel = true
                            else
                                nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                @sommets.push(nouveauSommet)
                                sommetPlaces += 1

                                nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(0..1) == 1) #TODO

                                sommetAEtePlace = true
                            end
                        elsif boolAreteJusteDevant
                            puts "Arret via areteDevant en " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                            #si on peut placer sur l'arete on le fait, sinon on recul
                            caseDArete = @grille.getCase(caseOuPlacer.x + lesAdds[0], caseOuPlacer.y + lesAdds[1])
                            if !(caseDArete.aSommetVoisin()) && caseDArete.contenu.getTaille() >= 3
                                sommet1 = caseDArete.contenu.getSommet1()
                                sommet2 = caseDArete.contenu.getSommet2()
                                caseDArete.supprimer()

                                nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                @sommets.push(nouveauSommet)
                                sommetPlaces += 1

                                nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(0..1) == 1) #TODO

                                sommetAEtePlace = true

                                nouvelleArete1 = Arete.creer(sommet1, nouveauSommet, rand(0..1) == 1) #TODO
                                nouvelleArete2 = Arete.creer(sommet2, nouveauSommet, rand(0..1) == 1) #TODO
                            else
                                #sinon on recule jusqu'a trouver un truc bien
                                while caseOuPlacer.aSommetVoisin()
                                    caseOuPlacer = @grille.getCase(caseOuPlacer.x - lesAdds[0], caseOuPlacer.y - lesAdds[1])
                                    break if caseOuPlacer == sommetChoisi.position
                                end

                                #on teste pourquoi on s'est arrete
                                if caseOuPlacer == sommetChoisi.position
                                    aEteCancel = true
                                else
                                    nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                    @sommets.push(nouveauSommet)
                                    sommetPlaces += 1

                                    nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(0..1) == 1) #TODO

                                    sommetAEtePlace = true
                                end
                            end
                        elsif boolBordDuTableau
                            puts "Arret via bord " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                            if !(caseOuPlacer.aSommetVoisin())
                                nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                @sommets.push(nouveauSommet)
                                sommetPlaces += 1

                                nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(0..1) == 1) #TODO

                                sommetAEtePlace = true
                            else
                                #sinon, on recule jusqu'a trouver un endroit bien
                                while caseOuPlacer.aSommetVoisin()
                                    caseOuPlacer = @grille.getCase(caseOuPlacer.x - lesAdds[0], caseOuPlacer.y - lesAdds[1])
                                    break if caseOuPlacer == sommetChoisi.position
                                end

                                #on teste pourquoi on s'est arrete
                                if caseOuPlacer == sommetChoisi.position
                                    aEteCancel = true
                                else
                                    nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                    @sommets.push(nouveauSommet)
                                    sommetPlaces += 1

                                    nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(0..1) == 1) #TODO

                                    sommetAEtePlace = true
                                end
                            end
                        elsif boolArretViaRand
                            puts "Arret via rand en " + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                            #on verifie qu'il n'y a rien autour
                            if !(caseOuPlacer.aSommetVoisin())
                                nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                @sommets.push(nouveauSommet)
                                sommetPlaces += 1

                                nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(0..1) == 1) #TODO

                                sommetAEtePlace = true
                            else
                                #sinon, on recule jusqu'a trouver un endroit bien
                                while caseOuPlacer.aSommetVoisin()
                                    caseOuPlacer = @grille.getCase(caseOuPlacer.x - lesAdds[0], caseOuPlacer.y - lesAdds[1])
                                    break if caseOuPlacer == sommetChoisi.position
                                end

                                #on teste pourquoi on s'est arrete
                                if caseOuPlacer == sommetChoisi.position
                                    aEteCancel = true
                                else
                                    nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                    @sommets.push(nouveauSommet)
                                    sommetPlaces += 1

                                    nouvelleArete = Arete.creer(nouveauSommet, sommetChoisi, rand(0..1) == 1) #TODO

                                    sommetAEtePlace = true
                                end
                            end
                        end
                    else
                        #si aucun arret est lancé, on avance juste
                        caseOuPlacer = @grille.caseSuivante(caseOuPlacer, lesAdds[0], lesAdds[1])
                        puts "on a avancé"
                    end
                }
            end
            @grille.afficher()
        }

        placerLabelSommet()
        return getGrilleSansArete()
    end
end
