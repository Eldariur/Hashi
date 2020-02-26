load "Grille.rb"
load "Case.rb"
load "Sommet.rb"
load "Arete.rb"
load "Generateur.rb"

gene = Generateur.new(10, 10, 10)
grille = gene.creeUneGrillev2(10)
grille.afficher()
