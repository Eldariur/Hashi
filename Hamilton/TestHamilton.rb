require_relative "../Plateau/Grille.rb"
require_relative "../Plateau/Case.rb"
require_relative "../Plateau/Sommet.rb"
require_relative "../Plateau/Arete.rb"
require_relative "../Undo/Undo.rb"

#Création d'une première grille.
grille = Grille.creer(7, 7)

sommet1 = Sommet.creer(3, grille.getCase(0, 1))
sommet2 = Sommet.creer(5, grille.getCase(0, 3))
sommet3 = Sommet.creer(3, grille.getCase(0, 6))
sommet4 = Sommet.creer(2, grille.getCase(1, 2))
sommet5 = Sommet.creer(1, grille.getCase(2, 1))
sommet6 = Sommet.creer(3, grille.getCase(3, 0))
sommet7 = Sommet.creer(4, grille.getCase(3, 2))
sommet8 = Sommet.creer(1, grille.getCase(5, 2))
sommet9 = Sommet.creer(3, grille.getCase(6, 0))
sommet10 = Sommet.creer(5, grille.getCase(6, 3))
sommet11 = Sommet.creer(4, grille.getCase(6, 6))

arete1 = Arete.creer(sommet1, sommet2, true)
arete2 = Arete.creer(sommet2, sommet3)
arete3 = Arete.creer(sommet1, sommet5)
arete4 = Arete.creer(sommet2, sommet10, true)
arete5 = Arete.creer(sommet3, sommet11, true)
arete6 = Arete.creer(sommet4, sommet7, true)
arete7 = Arete.creer(sommet6, sommet7)
arete8 = Arete.creer(sommet7, sommet8)
arete9 = Arete.creer(sommet6, sommet9, true)
arete10 = Arete.creer(sommet9, sommet10)
arete11 = Arete.creer(sommet10, sommet11)

#Affichage de la grille.
grille.afficher()

#Résultat parcours hamiltonien possible :
puts 'Il y a un parcours hamiltonien : '+grille.testHamilton?().to_s
