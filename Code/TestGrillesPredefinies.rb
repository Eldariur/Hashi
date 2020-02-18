
load "Grilles"
load "Case.rb"
load "Sommet.rb"
load "Arete.rb"

# Test de génération de grilles prédéfinies

grille1 = Grille.new(10, 10)
grille1.completerInitialize()
sommet11 = Sommet.new(4, grille1.getCase(1, 1))
sommet12 = Sommet.new(2, grille1.getCase(3, 1))
sommet13 = Sommet.new(2, grille1.getCase(1, 4))
arete11 = Arete.new(sommet11, sommet13,true)
arete11.completerInitialize()
grille1.addSommet(sommet11)
grille1.addSommet(sommet12)
grille1.addSommet(sommet13)
grille1.addArete(arete11)

grille2 = Grille.new(7, 9)
grille2.completerInitialize()
sommet21 = Sommet.new(2, grille2.getCase(2, 4))
sommet22 = Sommet.new(1, grille2.getCase(2, 2))
sommet23 = Sommet.new(1, grille2.getCase(2, 6))
arete21 = Arete.new(sommet21, sommet22)
arete21.completerInitialize()
arete22 = Arete.new(sommet21, sommet23)
arete22.completerInitialize()
grille2.addSommet(sommet21)
grille2.addSommet(sommet22)
grille2.addSommet(sommet23)
grille2.addArete(arete21)
grille2.addArete(arete22)

grille1.afficher()

grille2.afficher()
