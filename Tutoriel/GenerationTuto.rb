load "../Code/Grille.rb"
load "../Code/Case.rb"
load "../Code/Sommet.rb"
load "../Code/Arete.rb"
load "../Sauvegarde/Sauvegarde.rb"

if(!Dir.exist?('Basique') && !Dir.exist?('Avancée')) then
  Dir::mkdir("Basique", 0777)
  Dir::mkdir("Avancée", 0777)
end

##BASIQUE

#1
grille = Grille.creer(1, 3)

Sommet.creer(1, grille.getCase(0, 0))
Sommet.creer(1, grille.getCase(0, 2))
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,0)
save.sauvegarderAvecNom("Basique/1.sav")
#

#2
grille = Grille.creer(3, 4)

Sommet.creer(3, grille.getCase(0, 0))
Sommet.creer(2, grille.getCase(0, 3))
Sommet.creer(1, grille.getCase(2, 0))
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,0)
save.sauvegarderAvecNom("Basique/2.sav")
#

#3
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

save = Sauvegarde.nouvelle(grille,nil,0)
save.sauvegarderAvecNom("Basique/3.sav")
#

#4
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

save = Sauvegarde.nouvelle(grille,nil,0)
save.sauvegarderAvecNom("Basique/4.sav")
#

##AVANCEE

#1
grille = Grille.creer(3, 3)

Sommet.creer(1, grille.getCase(0, 2))
Sommet.creer(2, grille.getCase(2, 0))
Sommet.creer(3, grille.getCase(2, 2))
grille.afficher

while(gets == nil) do end

save = Sauvegarde.nouvelle(grille,nil,0)
save.sauvegarderAvecNom("Avancée/1.sav")
#
