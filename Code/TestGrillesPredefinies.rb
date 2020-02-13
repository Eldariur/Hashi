
load "Grille.rb"
load "Case.rb"
load "Sommet.rb"

# Test de génération de grilles prédéfinies

grille1 = Grille.new(5, 5)
sommet11 = Sommet.new(4, grille1.getCase(0, 0))
sommet12 = Sommet.new(2, grille1.getCase(2, 0))
sommet13 = Sommet.new(2, grille1.getCase(0, 3))
grille1.addSommet(sommet11)
grille1.addSommet(sommet12)
grille1.addSommet(sommet13)

grille2 = Grille.new(5, 5)
sommet21 = Sommet.new(2, grille2.getCase(2, 2))
sommet22 = Sommet.new(1, grille2.getCase(2, 0))
sommet23 = Sommet.new(1, grille2.getCase(2, 4))
grille2.addSommet(sommet21)
grille2.addSommet(sommet22)
grille2.addSommet(sommet23)

print(grille1.to_s())

print(grille2.to_s())
