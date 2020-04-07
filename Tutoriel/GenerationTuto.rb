load "../Code/Grille.rb"
load "../Code/Case.rb"
load "../Code/Sommet.rb"
load "../Code/Arete.rb"
load "../Sauvegarde/Sauvegarde.rb"
load "../Code/Undo.rb"

if(!Dir.exist?('Niveaux')) then
  Dir::mkdir("Niveaux", 0777)
end

count = 0

##BASIQUE
puts "BASIQUE"


#1
count += 1
puts '#'+count.to_s
grille = Grille.creer(1, 3)

Sommet.creer(1, grille.getCase(0, 0))
Sommet.creer(1, grille.getCase(0, 2))
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/D1.sav")
#

#2
count += 1
puts '#'+count.to_s
grille = Grille.creer(3, 4)

Sommet.creer(3, grille.getCase(0, 0))
Sommet.creer(2, grille.getCase(0, 3))
Sommet.creer(1, grille.getCase(2, 0))
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/D2.sav")
#

#3
count += 1
puts '#'+count.to_s
grille = Grille.creer(5, 5)

Sommet.creer(2, grille.getCase(0, 0))
Sommet.creer(1, grille.getCase(0, 2))
Sommet.creer(2, grille.getCase(2, 0))
Sommet.creer(2, grille.getCase(2, 4))
Sommet.creer(1, grille.getCase(4, 2))
Sommet.creer(2, grille.getCase(4, 4))
Arete.creer(grille.getCase(0,2).contenu, grille.getCase(4,2).contenu)
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/D3.sav")
#

#4
count += 1
puts '#'+count.to_s
grille = Grille.creer(7, 7)

Sommet.creer(3, grille.getCase(0, 0))
Sommet.creer(4, grille.getCase(0, 2))
Sommet.creer(6, grille.getCase(0, 4))
Sommet.creer(3, grille.getCase(0, 6))
Sommet.creer(2, grille.getCase(2, 2))
Sommet.creer(3, grille.getCase(2, 4))
Sommet.creer(6, grille.getCase(4, 0))
Sommet.creer(3, grille.getCase(4, 6))
Sommet.creer(4, grille.getCase(6, 0))
Sommet.creer(2, grille.getCase(6, 5))
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/D4.sav")
#

count = 0

##AVANCEE
puts "AVANCEE"

#1
count += 1
puts '#'+count.to_s
grille = Grille.creer(3, 3)

Sommet.creer(1, grille.getCase(0, 2))
Sommet.creer(2, grille.getCase(2, 0))
Sommet.creer(3, grille.getCase(2, 2))
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A1.sav")
#

#2
count += 1
puts '#'+count.to_s
grille = Grille.creer(5, 5)

Sommet.creer(2, grille.getCase(0, 2))
Sommet.creer(2, grille.getCase(2, 0))
Sommet.creer(8, grille.getCase(2, 2))
Sommet.creer(2, grille.getCase(2, 4))
Sommet.creer(2, grille.getCase(4, 2))
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A2.sav")
#

#3
count += 1
puts '#'+count.to_s
grille = Grille.creer(5, 3)

Sommet.creer(2, grille.getCase(0, 2))
Sommet.creer(2, grille.getCase(2, 0))
Sommet.creer(2, grille.getCase(4, 2))
Sommet.creer(6, grille.getCase(2, 2))
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A3.sav")
#

#4
count += 1
puts '#'+count.to_s
grille = Grille.creer(3, 3)

Sommet.creer(2, grille.getCase(0, 0))
Sommet.creer(2, grille.getCase(2, 2))
Sommet.creer(4, grille.getCase(0, 2))
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A4.sav")
#

#5
count += 1
puts '#'+count.to_s
grille = Grille.creer(5, 3)

Sommet.creer(2, grille.getCase(0, 2))
Sommet.creer(2, grille.getCase(2, 0))
Sommet.creer(1, grille.getCase(4, 2))
Sommet.creer(5, grille.getCase(2, 2))
Arete.creer(grille.getCase(0,2).contenu, grille.getCase(2,2).contenu)
Arete.creer(grille.getCase(2,0).contenu, grille.getCase(2,2).contenu)
Arete.creer(grille.getCase(4,2).contenu, grille.getCase(2,2).contenu)
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A5.sav")
#

#6
count += 1
puts '#'+count.to_s
grille = Grille.creer(5, 5)

Sommet.creer(2, grille.getCase(0, 2))
Sommet.creer(2, grille.getCase(2, 0))
Sommet.creer(7, grille.getCase(2, 2))
Sommet.creer(2, grille.getCase(2, 4))
Sommet.creer(1, grille.getCase(4, 2))
Arete.creer(grille.getCase(0,2).contenu, grille.getCase(2,2).contenu)
Arete.creer(grille.getCase(2,0).contenu, grille.getCase(2,2).contenu)
Arete.creer(grille.getCase(2,4).contenu, grille.getCase(2,2).contenu)
Arete.creer(grille.getCase(4,2).contenu, grille.getCase(2,2).contenu)
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A6.sav")
#

#7
count += 1
puts '#'+count.to_s
grille = Grille.creer(3, 5)

Sommet.creer(1, grille.getCase(0, 0))
Sommet.creer(1, grille.getCase(0, 4))
Sommet.creer(2, grille.getCase(2, 2))
Sommet.creer(4, grille.getCase(0, 2))
Arete.creer(grille.getCase(0,0).contenu, grille.getCase(0,2).contenu)
Arete.creer(grille.getCase(0,4).contenu, grille.getCase(0,2).contenu)
Arete.creer(grille.getCase(2,2).contenu, grille.getCase(0,2).contenu)
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A7.sav")
#

#8
count += 1
puts '#'+count.to_s
grille = Grille.creer(4, 5)

Sommet.creer(1, grille.getCase(0, 2))
Sommet.creer(1, grille.getCase(1, 0))
Sommet.creer(1, grille.getCase(1, 4))
Sommet.creer(3, grille.getCase(3, 0))
Sommet.creer(3, grille.getCase(3, 2))
Sommet.creer(2, grille.getCase(3, 4))

Arete.creer(grille.getCase(1,0).contenu, grille.getCase(1,4).contenu)

grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A8.sav")
#

#9
count += 1
puts '#'+count.to_s
grille = Grille.creer(5, 5)

Sommet.creer(2, grille.getCase(0, 2))
Sommet.creer(2, grille.getCase(2, 0))
Sommet.creer(6, grille.getCase(2, 2))
Sommet.creer(1, grille.getCase(2, 4))
Sommet.creer(2, grille.getCase(4, 0))
Sommet.creer(6, grille.getCase(4, 2))
Sommet.creer(3, grille.getCase(4, 4))

Arete.creer(grille.getCase(2,2).contenu, grille.getCase(0,2).contenu)
Arete.creer(grille.getCase(2,2).contenu, grille.getCase(2,0).contenu)
Arete.creer(grille.getCase(2,2).contenu, grille.getCase(4,2).contenu)

grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A9.sav")
#

#10
count += 1
puts '#'+count.to_s
grille = Grille.creer(3, 3)

Sommet.creer(2, grille.getCase(0, 0))
Sommet.creer(1, grille.getCase(0, 2))
Sommet.creer(2, grille.getCase(2, 0))
Sommet.creer(1, grille.getCase(2, 2))

Arete.creer(grille.getCase(0,0).contenu, grille.getCase(2,0).contenu,true)
Arete.creer(grille.getCase(2,2).contenu, grille.getCase(0,2).contenu)

grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A10.sav")
#

#11
count += 1
puts '#'+count.to_s
grille = Grille.creer(5, 3)

Sommet.creer(2, grille.getCase(0, 0))
Sommet.creer(3, grille.getCase(2, 0))
Sommet.creer(2, grille.getCase(2, 2))
Sommet.creer(1, grille.getCase(4, 0))
Sommet.creer(2, grille.getCase(4, 2))

Arete.creer(grille.getCase(0,0).contenu, grille.getCase(2,0).contenu)
Arete.creer(grille.getCase(2,0).contenu, grille.getCase(4,0).contenu)
Arete.creer(grille.getCase(2,2).contenu, grille.getCase(4,2).contenu,true)

grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A11.sav")
#

#12
count += 1
puts '#'+count.to_s
grille = Grille.creer(5, 5)

Sommet.creer(2, grille.getCase(0, 2))
Sommet.creer(2, grille.getCase(0, 4))
Sommet.creer(2, grille.getCase(2, 2))
Sommet.creer(4, grille.getCase(2, 4))
Sommet.creer(2, grille.getCase(4, 0))
Sommet.creer(3, grille.getCase(4, 2))
Sommet.creer(3, grille.getCase(4, 4))

Arete.creer(grille.getCase(4,0).contenu, grille.getCase(4,2).contenu,true)
Arete.creer(grille.getCase(4,2).contenu, grille.getCase(4,4).contenu)
Arete.creer(grille.getCase(4,4).contenu, grille.getCase(2,4).contenu,true)

grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,nil,0)
save.sauvegarderAvecNom("Niveaux/A12.sav")
#
