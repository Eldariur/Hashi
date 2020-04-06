load "../Code/Grille.rb"
load "../Code/Case.rb"
load "../Code/Sommet.rb"
load "../Code/Arete.rb"
load "../Chrono/Chronometre.rb"
load "Sauvegarde.rb"
load "../Code/Undo.rb"

# Test de génération de grilles prédéfinies

#Création d'une première grille
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
#arete2 = Arete.creer(sommet2, sommet3)
arete3 = Arete.creer(sommet1, sommet5)
arete4 = Arete.creer(sommet2, sommet10, true)
#arete5 = Arete.creer(sommet3, sommet11, true)
arete6 = Arete.creer(sommet4, sommet7, true)
arete7 = Arete.creer(sommet6, sommet7)
arete8 = Arete.creer(sommet7, sommet8)
arete9 = Arete.creer(sommet6, sommet9, true)
arete10 = Arete.creer(sommet9, sommet10)
arete11 = Arete.creer(sommet10, sommet11)

#Affichage des grilles
grille.afficher()

#Sauvegarde.genenerDossier();


while(gets == nil) do end

puts "Debut hypothese"
Sauvegarde.nouvelleHypothese(grille)
arete2 = Arete.creer(sommet2, sommet3)
arete5 = Arete.creer(sommet3, sommet11, true)
puts "Ajout 2 aretes sur sommet coin haut droite"
grille.afficher()
puts "Annulation hypothese"
grille = Sauvegarde.annulerHypothese()
grille.afficher()

while(gets == nil) do end

puts "Debut hypothese"
Sauvegarde.nouvelleHypothese(grille)
arete2 = Arete.creer(grille.getCase(0,3).contenu, grille.getCase(0,6).contenu)
arete5 = Arete.creer(grille.getCase(0,6).contenu, grille.getCase(6,6).contenu, true)
puts "Ajout 2 aretes sur sommet coin haut droite"
grille.afficher()
puts "Validation hypothese"
Sauvegarde.validerHypothese()
grille.afficher()


c = Chrono.nouveau()

threads = []
threads << Thread.new {c.chronometrer()}
threads << Thread.new {stopsaisie(c)}
#threads << Thread.new {stoptemps(2,c)}

threads.each { |thr| thr.join }
puts 'Resultat : '+ c.to_chrono() + ' | Total : ' + c.resultat().to_s


save1 = Sauvegarde.nouvelle(grille,nil,c,"easy")
save2 = Sauvegarde.nouvelle(grille,nil,c,"normal")
save3 = Sauvegarde.nouvelle(grille,nil,c,"hard")
save4 = Sauvegarde.nouvelle(grille,nil,c,"hard",true)

puts c

save1.sauvegarder()
save2.sauvegarder()
save3.sauvegarder()
save4.sauvegarder()

saveres = Sauvegarde.nouvelle(nil,nil,nil,1,false).charger()
puts saveres
saveres = Sauvegarde.nouvelle(nil,nil,nil,2,false).charger()
puts saveres
saveres = Sauvegarde.nouvelle(nil,nil,nil,3,false).charger()
puts saveres
saveres = Sauvegarde.nouvelle(nil,nil,nil,3,true).charger()
puts saveres

#Sauvegarde.deleteAllSave()
