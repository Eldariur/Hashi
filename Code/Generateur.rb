require "matrix"

class Generateur
    #@longeur
    #@largeur
    #@grille
    #@sommets

    def initialize(longeur, largeur, densite)
        @longeur = longeur
        @largeur = largeur
        @sommets = Array.new()
        #(@longeur * @largeur) / (@sommets.length() + 1) * 100;
        @densite = densite
        @nbSommet = (@longeur * @largeur / @densite).ceil
        @grille = @grille.new(@longeur, @largeur)
        @grille.completerInitialize()
    end

    def getCase(x, y)
        return @grille[x][y]
    end

    def vider()
        for i in 0...@longeur do
            for j in 0...@largeur do
                @grille.table[i][j] = nil
            end
        end
    end

    def placerSommet()

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
        vider()
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
            #On choisi un sommet dans la liste des sommets dejà placés
            indiceSommetChoisi = rand(0...@grille.sommet.length)
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
                boolLargeurTropHaute = sommetChoisi.position.y + 2*lesAdds[0] >= @largeur
                boolLargeurTropBasse = sommetChoisi.position.y + 2*lesAdds[0] < 0

            break if sommetPlaces == nbSommet
        end
    end
end
