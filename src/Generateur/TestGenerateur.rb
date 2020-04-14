require_relative "../Plateau/Grille.rb"
require_relative "../Plateau/Case.rb"
require_relative "../Plateau/Sommet.rb"
require_relative "../Plateau/Arete.rb"
require_relative "../Generateur/Generateur.rb"

#gene = Generateur.new("easy")
#gene = Generateur.new("normal")
gene = Generateur.new("hard")
#gene = Generateur.new(nil,5, 5, 5)
grille = gene.creeUneGrille()
#grille = gene.creeUneGrille(10)
grille.afficher()
