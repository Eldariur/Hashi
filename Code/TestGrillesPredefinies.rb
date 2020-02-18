
load "Grille.rb"
load "Case.rb"
load "Sommet.rb"
load "Arete.rb"

# Test de génération de grilles prédéfinies

grille1 = Grille.new(5, 5)
grille1.completerInitialize()
sommet11 = Sommet.new(4, grille1.getCase(0, 0))
sommet12 = Sommet.new(2, grille1.getCase(2, 0))
sommet13 = Sommet.new(2, grille1.getCase(0, 3))
arete11 = Arete.new(sommet11, sommet13)
arete11.completerInitialize()
grille1.addSommet(sommet11)
grille1.addSommet(sommet12)
grille1.addSommet(sommet13)
grille1.addArete(arete11)

grille2 = Grille.new(5, 5)
grille2.completerInitialize()
sommet21 = Sommet.new(2, grille2.getCase(2, 2))
sommet22 = Sommet.new(1, grille2.getCase(2, 0))
sommet23 = Sommet.new(1, grille2.getCase(2, 4))
arete21 = Arete.new(sommet21, sommet22)
arete21.completerInitialize()
arete22 = Arete.new(sommet21, sommet23)
arete22.completerInitialize()
grille2.addSommet(sommet21)
grille2.addSommet(sommet22)
grille2.addSommet(sommet23)
grille2.addArete(arete21)
grille2.addArete(arete22)

print(grille1.to_s())

print(grille2.to_s())
