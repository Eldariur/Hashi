
load "Grille.rb"
load "Case.rb"
load "Sommet.rb"
load "Arete.rb"

# Test de génération de grilles prédéfinies

#Création d'une première grille
grille1 = Grille.creer(5, 5)
sommet11 = Sommet.creer(4, grille1.getCase(0, 0))
sommet12 = Sommet.creer(2, grille1.getCase(2, 0))
sommet13 = Sommet.creer(2, grille1.getCase(0, 3))
arete11 = Arete.creer(sommet11, sommet13)
#grille1.addSommet(sommet11)
#grille1.addSommet(sommet12)
#grille1.addSommet(sommet13)

#Création d'une deuxième grille
grille2 = Grille.creer(5, 5)
sommet21 = Sommet.creer(2, grille2.getCase(2, 2))
sommet22 = Sommet.creer(1, grille2.getCase(2, 0))
sommet23 = Sommet.creer(1, grille2.getCase(2, 4))
arete21 = Arete.creer(sommet21, sommet22)
arete22 = Arete.creer(sommet21, sommet23)
#grille2.addSommet(sommet21)
#grille2.addSommet(sommet22)
#grille2.addSommet(sommet23)

#Affichage des grilles
#print(grille1.to_s())
#print(grille2.to_s())
grille1.afficher()
grille2.afficher()
