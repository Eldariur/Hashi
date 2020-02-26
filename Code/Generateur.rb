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
        @nbSommet = (@longueur * @largeur / @densite).ceil
        @grille = Grille.creer(@longueur, @largeur)
    end

    def getCase(x, y)
        return @grille[x][y]
    end

    def vider()
        @grille = Grille.creer(@longueur, @largeur)
    end

    def getGrilleSansSommet()
        cloneGrille = Marshal.load(Marshal.dump(@grille))
        cloneGrille.clearAretes()
        return cloneGrille
    end

    def placerLabelSommet()
        @sommets.each { |sommet|
            sommet.setValeur(sommet.compterArete())
        }
    end

    def creeUneGrille(nbSommet)
        #On commence par vider le tableau actuel
        self.vider()
        #Tableau permettant le deplacement dans la matrice sans se soucier du sens
        tableauDeAdd = [[0,1],[0,-1],[1,0],[-1,0]]
        tableau = @grille.table
        sommetPlaces = 0

        #On cherche une premiere position ou placer un sommet
        posX = rand(0...@longueur)
        posY = rand(0...@largeur)
        #Tant que la position est pas valide (normalement ca arrive pas mais quand meme) on cherche un autre sommet
        while tableau[posX, posY].contenu != nil
            puts "pas trouve"
            posX = rand(0...@longueur)
            posY = rand(0...@largeur)
        end
        #On crée le nouveau sommet et on l'ajoute a la liste de sommets
        sommet = Sommet.new(nil, tableau[posX, posY])
        @sommets << sommet
        @grille.addSommet(sommet)
        sommetPlaces += 1
        #Execution a faire jusqu'a ce qu'on ai placé le nombre de sommet voulu
        loop do
            #On choisi un sommet dans la liste de sommet
            indicSommet = rand(0...@sommets.length)
            #On choisi une direction dans laquelle partir
            lesAdds = tableauDeAdd[rand(0...tableauDeAdd.length)]
            sommetChoisi = @sommets[indicSommet]
            #On vérifie que la direction est disponible (i.e. si il y a de la place a 2 case min. vu que 2 sommets ne peuvent pas etre adjacent)
            unless ((sommetChoisi.position.x + 2 * lesAdds[0] >= @longueur || sommetChoisi.position.x + 2 * lesAdds[0] < 0) || (sommetChoisi.position.y + 2 * lesAdds[1] >= @largeur || sommetChoisi.position.y + 2 * lesAdds[1] < 0))
                caseChoisie = tableau[posX, posY]
                caseOriginale = tableau[posX, posY]
                #On parcours les cases dans la direction choisie tant que :
                # - rand n'est pas 0 (1/2)
                # - on est pas au bord
                # - on est pas a 2 cases d'un sommet
                # - on ne croise pas une arrete, auquel cas :
                #   => si l'arrete fait 3 de taille ou plus, on se place dessus
                #   => sinon, on se place devant si possible
                #Une fois arreter, il faut vérifier si il n'y a pas des sommets adjacents. Si il y en a, on recule de 1 case et on refait le test
                #Si on ne trouve pas de case valide, on abandonne
                boolRand = false
                boolBord = false
                boolSommetProche = false
                boolArete = false
                loop do
                    caseChoisie = tableau[caseChoisie.x + lesAdds[0], caseChoisie.y + lesAdds[1]]
                    resRand = rand(2)

                    boolRand = resRand == 0
                    boolBord = (caseChoisie.x + lesAdds[0] == @longueur) || (caseChoisie.y + lesAdds[1] == @largeur)
                    #Pour chacun des tests, on vérifie d'abord si la case n'est pas en dehors du tableau
                    boolSommetProche = ((caseChoisie.x + lesAdds[0] != @longueur) || (caseChoisie.y + lesAdds[1] != @largeur)) && tableau[caseChoisie.x + 2 * lesAdds[0], caseChoisie.y + 2 * lesAdds[1]].is_a?(Sommet)
                    boolArete = ((caseChoisie.x + lesAdds[0] != @longueur) || (caseChoisie.y + lesAdds[1] != @largeur)) && tableau[caseChoisie.x + lesAdds[0], caseChoisie.y + lesAdds[1]].is_a?(Arete)
                    break if boolRand || boolBord || boolSommetProche || boolArete
                end
                caseSuivante = tableau[caseChoisie.x + lesAdds[0], caseChoisie.y + lesAdds[1]]
                boolPlaceSurArrete = false
                if boolArete
                    boolPlaceSurArrete = true
                    if caseSuivante.contenu.getTaille() >= 3
                        if caseSuivante.aSommetVoisin
                            boolPlaceSurArrete = false
                        else
                            #On recrée l'arrete en inserant le sommet que l'on crée au milieu
                            sommet1 = caseSuivante.contenu.getSommet1()
                            sommet2 = caseSuivante.contenu.getSommet2()
                            caseSuivante.contenu.supprimer()
                            nouvSommet = Sommet.new(nil, caseChoisie)
                                @sommets << nouvSommet
                                @grille.addSommet(nouvSommet)
                                sommetPlaces += 1
                            arete = Arete.new(sommet1, nouvSommet, rand(3) == 0)
                            arete.completerInitialize()
                            arete = Arete.new(sommet2, nouvSommet, rand(3) == 0)
                            arete.completerInitialize()
                            arete = Arete.new(sommetChoisi, nouvSommet, rand(3) == 0)
                        end
                    else
                        boolPlaceSurArrete = false
                    end
                end
                if (boolRand || boolBord || boolSommetProche) && !boolPlaceSurArrete
                    #Tant que on ne trouve pas d'emplacement valide, on revient en arriere, jusqu'a trouver une case valide ou jusqu'a ce qu'on revienne a la case de depart
                    loop do
                        break if !(caseChoisie.aSommetVoisin()) || caseChoisie == caseOriginale
                        caseChoisie = tableau[caseChoisie.x - lesAdds[0], caseChoisie.y - lesAdds[1]]
                    end
                    unless caseChoisie == caseOriginale
                        nouvSommet = Sommet.new(nil, caseChoisie)
                            @sommets << nouvSommet
                            @grille.addSommet(nouvSommet)
                            sommetPlaces += 1
                        arete = Arete.new(sommetChoisi, nouvSommet, rand(3) == 0)
                    end
                end
            end
            break if sommetPlaces == nbSommet
        end
    end

    def creeUneGrillev2(nbSommet)
        #On vide la grille précédente
        self.vider()
        #Tableau permettant le deplacement dans la matrice sans se soucier du sens
        tableauDeAdd = [[0,1],[0,-1],[1,0],[-1,0]]
        #On recupere le tableau de la grille pour un acces plus simple
        tableau = @grille.table
        #On garde le nombre de sommet déjà placé
        sommetPlaces = 0

        #On commence l'algorithme en choisissant une premiere case dans le tableau
        coordXPremierSommet = rand(0...@longueur)
        coordYPremierSommet = rand(0...@largeur)
        #puts coordXPremierSommet #test des coordonées de depart
        #puts coordYPremierSommet
        #Pas la peine de verifier si la position est valide, vu qu'il n'y a aucun sommet dans la matrice

        #On crée le sommet de depart, on set sa valeur a 0, c'est une valeur impossible donc facile a reperer pour la modifier
        sommetDeDepart = Sommet.creer(0, @grille.getCase(coordXPremierSommet, coordYPremierSommet))
        #On ajoute le nouveau sommet a la liste des sommets
        @sommets.push(sommetDeDepart)
        #On incremente le total de sommets placés
        sommetPlaces += 1
        #On place des sommets tant qu'on a pas atteint le nombre de sommet a placer
        loop do
puts "tour de boucle : " + sommetPlaces.to_s + "/" + nbSommet.to_s

            #On choisi un sommet dans la liste des sommets dejà placés
            indiceSommetChoisi = rand(0...@grille.sommets.length)
            #On choisi une direction dans laquelle partir
            #basiquement, on choisi une des case du tableau des add, puis on ajoutera les case 0 et 1
            #aux coordonées x et y des sommets pour allez dans cette direction
            lesAdds = tableauDeAdd[rand(0...tableauDeAdd.length)]
            #On recupere le sommet qui a ete choisi comme point de depart
            sommetChoisi = @sommets[indiceSommetChoisi]
            #puts sommetChoisi #affichage de test
            #On fait les tests pour savoir si la direction choisie ne mene pas a un endroit illegal
                #test pour le hors tableau (on teste avec *2 les valeurs d'incrementations car 2 somemts ne peuvent etre collés)
                boolLongueurTropHaute = sommetChoisi.position.x + 2*lesAdds[0] >= @longueur
                boolLongueurTropBasse = sommetChoisi.position.x + 2*lesAdds[0] < 0
                boolLargeurTropHaute = sommetChoisi.position.y + 2*lesAdds[1] >= @largeur
                boolLargeurTropBasse = sommetChoisi.position.y + 2*lesAdds[1] < 0
            unless (boolLargeurTropBasse) && (boolLargeurTropHaute) && (boolLongueurTropBasse) && (boolLongueurTropHaute)
                #On parcours les cases dans la direction choisie jusqu'a remplir une condition d'arret
                #conditions d'arret :
                # - le rand tombe sur 1 (1 chance sur 2 a ajuster)
                # - on est au bord du tableau (on atteint 0 ou longueur/largeur - 1)
                # - On est a 2 case d'un sommet droit devant
                # - Il y a une arrete a 1 case devant
                #       Si l'arrete fait 3 de taille ou plus, on se place sur l'arrete
                #       Sinon, on se place devant elle
                #La condition a tester le plus possible est la presence de sommet adjacent, car 2 sommets ne peuvent PAS etre adjacents
                #On cree les 3 case a utiliser, la case ou on placera peut etre, la case juste devant pour tester les arrete, la case a 2 devant pour tester les sommets
                caseOuPlacer = sommetChoisi.position
                caseUnDevant = tableau[caseOuPlacer.x + lesAdds[0], caseOuPlacer.y + lesAdds[1]]
                caseDeuxDevant = tableau[caseUnDevant.x + lesAdds[0], caseUnDevant.y + lesAdds[1]]


                boolSommetPlace = false #condition d'arret de loop
                loop do #la loop pour faire avancer
puts "On est en" + caseOuPlacer.x.to_s + ":" + caseOuPlacer.y.to_s
                    break if boolSommetPlace
                    caseUnDevant = tableau[caseOuPlacer.x + lesAdds[0], caseOuPlacer.y + lesAdds[1]]
                    caseDeuxDevant = tableau[caseUnDevant.x + lesAdds[0], caseUnDevant.y + lesAdds[1]]

                    boolAreteDevant = caseUnDevant.class == NilClass ? false : (caseUnDevant.contenu.class == Arete)
                    boolSommetDevant = caseDeuxDevant.class == NilClass ? false : (caseDeuxDevant.contenu.class == Sommet)
                    boolArretViaRand = rand(0..1) == 1
                    boolOnVaTropLoin = caseOuPlacer.x == @longueur - 1 || caseOuPlacer.x - 1 < 0 || caseOuPlacer.x == @largeur - 1 || caseOuPlacer.y - 1 < 0
                    #Si la case juste devant la ou on veut placer est au bord du vide alors qu'on ne s'est pas arrété avant, alors c'est que la case est safe, on check juste les sommets proche
                    if boolOnVaTropLoin && !(caseOuPlacer.aSommetVoisin())
                        #On place le sommet et on créer l'arete
                        nouveauSommet = Sommet.creer(0, caseOuPlacer)
                        @sommets.push(nouveauSommet)
                        sommetPlaces += 1
                        nouvelleArete = Arete.creer(sommetChoisi, nouveauSommet, rand(0..1)==1) #chances d'avoir des doubles a ajuster
                        boolSommetPlace = true

                    elsif boolSommetDevant || boolArretViaRand
                        #Si on s'arrete a cause du rand ou parce qu'il y a un sommet devant, c'est le meme traitement pour les deux
                        #on regarde si on peut placer a l'endroit ou on est, sinon, on recule jusqu'a pouvoir ou jusqu'a retomber sur le sommet de departn auquel cas on abandonne
                        loop do
                            puts "tour de boucle de recul"
                            break if !(caseOuPlacer.aSommetVoisin()) || ((caseOuPlacer.x == sommetChoisi.position.x) && (caseOuPlacer.y == sommetChoisi.position.y))
                            caseOuPlacer = tableau(caseOuPlacer.x - lesAdds[0],caseOuPlacer.y - lesAdds[1])
                        end
                        #booleen pur savoir si on peut placer un sommet (test de la condition d'arrete de la loop)
                        bSommetPeutEtrePlace = !(caseOuPlacer.x == sommetChoisi.position.x) ? true : false
                        #si on doit placer le sommet, on le fait
                        if bSommetPeutEtrePlace
                            nouveauSommet = Sommet.creer(0, caseOuPlacer)
                            @sommets.push(nouveauSommet)
                            sommetPlaces += 1
                            nouvelleArete = Arete.creer(sommetChoisi, nouveauSommet, rand(0..1)==1) #chances d'avoir des doubles a ajuster
                            boolSommetPlace = true
                        end
                    elsif boolAreteDevant
                        areteTrouve = caseUnDevant.contenu()
                        #Si il y a une arete AB devant et qu'elle fait 3 ou plus de long, alors on doit recuperer ses deux sommet, la detruire, puis reconstruire 2 aretes qui relie AS et SB ou S et le sommet actuel
                        #Sinon, on se place devant si possible
                        if areteTrouve.getTaille >= 3 && !(caseUnDevant.aSommetVoisin())
                            #On recupere l'arrete et on la supprime en premier, pour liberer le contenu de la case
                            sommet1DeArete = areteTrouve.getSommet1()
                            sommet2DeArete = areteTrouve.getSommet2()
                            areteTrouve.supprimer()

                            #Creation du nouveau sommet
                            nouveauSommet = Sommet.creer(0, caseUnDevant)
                            @sommets.push(nouveauSommet)
                            sommetPlaces += 1
                            nouvelleArete = Arete.creer(sommetChoisi, nouveauSommet, rand(0..1)==1) #chances d'avoir des doubles a ajuster
                            boolSommetPlace = true

                            #Creation des nouvelles aretes
                            nouvelleArete1 = Arete.creer(sommet1, nouveauSommet, rand(0..1)==1) #chances d'avoir des doubles a ajuster
                            nouvelleArete2 = Arete.creer(nouveauSommet, sommet2, rand(0..1)==1) #chances d'avoir des doubles a ajuster
                        else
                            #on essaye de placer l'arete ou on s'est arreté (juste devant l'arete) ou alors on recule jusqu'a trouver
                            loop do
                                puts "tour de boucle de recul"
                                break if !(caseOuPlacer.aSommetVoisin()) || ((caseOuPlacer.x == sommetChoisi.position.x) && (caseOuPlacer.y == sommetChoisi.position.y))
                                caseOuPlacer = tableau(caseOuPlacer.x - lesAdds[0],caseOuPlacer.y - lesAdds[1])
                            end
                            #booleen pur savoir si on a placé un sommet
                            bSommetPeutEtrePlace = !(caseOuPlacer.x == sommetChoisi.position.x) ? true : false
                            #si on doit placer le sommet, on le fait
                            if bSommetPeutEtrePlace
                                nouveauSommet = Sommet.creer(0, caseOuPlacer)
                                @sommets.push(nouveauSommet)
                                sommetPlaces += 1
                                nouvelleArete = Arete.creer(sommetChoisi, nouveauSommet, rand(0..1)==1) #chances d'avoir des doubles a ajuster
                                boolSommetPlace = true
                            end
                        end
                    end

                    #avancement de la boucle
                    caseOuPlacer = caseUnDevant
                end
            end
            break if sommetPlaces == nbSommet
        end
        self.placerLabelSommet()
        return self.getGrilleSansSommet()
    end
end
