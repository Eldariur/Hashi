
load "Grille.rb"
load "Case.rb"
load "Sommet.rb"
load "Arete.rb"
load "Aide.rb"

# Test de génération de grilles prédéfinies

# Création d'une première grille
#grille1 = Grille.creer(5, 5)
#sommet11 = Sommet.creer(4, grille1.getCase(0, 0))
#sommet12 = Sommet.creer(2, grille1.getCase(2, 0))
#sommet13 = Sommet.creer(2, grille1.getCase(0, 3))
#arete11 = Arete.creer(sommet11, sommet13)

# Création d'une deuxième grille
#grille2 = Grille.creer(5, 5)
#sommet21 = Sommet.creer(2, grille2.getCase(2, 2))
#sommet22 = Sommet.creer(1, grille2.getCase(2, 0))
#sommet23 = Sommet.creer(1, grille2.getCase(2, 4))
#arete21 = Arete.creer(sommet21, sommet22)
#arete22 = Arete.creer(sommet21, sommet23)

# Grille de test pour Aide
grille = Grille.creer(5, 5)
sommet8 = Sommet.creer(3, grille.getCase(2, 2))
sommet2_1 = Sommet.creer(1, grille.getCase(0, 2))
sommet2_2 = Sommet.creer(2, grille.getCase(2, 0))
#sommet2_3 = Sommet.creer(2, grille.getCase(4, 2))
#sommet2_4 = Sommet.creer(2, grille.getCase(2, 4))
aide = Aide.creer(grille)

#Affichage des grilles + aides
grille.afficher()
aide.afficherId()
