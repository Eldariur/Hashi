require 'gtk3'
require_relative '../Code/Grille.rb'
require_relative '../Code/Aide.rb'
require_relative '../Code/Case.rb'
require_relative '../Code/Sommet.rb'
require_relative '../Code/Arete.rb'
require_relative 'UnBoutonPerso.rb'
require_relative 'UnLabelPerso.rb'
require_relative 'UneCasePerso.rb'
require_relative '../Code/Generateur.rb'
require_relative '../Code/Undo.rb'
require_relative '../Sauvegarde/Sauvegarde.rb'

require_relative "../Chrono/Chronometre.rb"



class FenetreJeu < Gtk::Box

  #@@fenetre

  #@difficulte
	#@classe
	#@tailleArea
	#@largeurSurbri

	attr_reader :grilleTest, :longueur, :largeur

	def initialize(window, difficulte, classe, save = nil)
		#vbox = Gtk::Box.new(:VERTICAL)


		super(Gtk::Orientation::VERTICAL)

    @@fenetre = window

		@tailleArea = @@fenetre.default_size[1] / 4 * 3

    @difficulte = difficulte
		@classe = classe

		@presse = false
		@hypothese = false
		#self.updateData
		@listeInter = []
		x = 5
		y = 5

		puts "taille de ma fenetre = "+@@fenetre.default_size.to_s



		#####################################
		if(save == nil)
			@gene = Generateur.new(@difficulte)
			@grilleTest = @gene.creeUneGrille()
			@grilleDepart = @grilleTest
		else
			@gene = save.grilleDepart
			@grilleTest = save.grille
		end
		#####################################

		@longueur = @grilleTest.longueur
		@largeur = @grilleTest.largeur

		initTailleCase()

			@darea = Gtk::DrawingArea.new
			@cr = nil
			@nbClick = 0


			@darea.signal_connect "draw" do
					on_draw
			end

			# on_draw
			x=10
			y=10

			@@x1=0
			@@y1=0
			@@x2=0
			@@y2=0

			@aide = nil
			@caseAide = nil
			@erreurs = nil
			@afficherErreur = false

			initBoutonRetour
	    initBoutonHypo
			initBoutonAnnulHypo
			initBoutonValidHypo
	    initBoutonAide
			initLabelMessage
			initBoutonErreurVisu
			initBoutonAideTxt
			initBoutonAideVisu
	    initBoutonAnnul
	    initBoutonRecom
	    initChrono
	    initBoxJeu

	    hboxBoutonRetour = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
				hboxBoutonRetour.halign = Gtk::Align::START
				#hboxBoutonRetour.homogeneous = true
	        hboxBoutonRetour.add(@boutonRetour)

	    hboxBoutonJeu = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
	  		hboxBoutonJeu.halign = Gtk::Align::FILL
	  		hboxBoutonJeu.homogeneous = true
	        hboxBoutonJeu.add(@boutonHypo)
	        hboxBoutonJeu.add(@boutonAide)
	        hboxBoutonJeu.add(@boutonAnnul)
	        hboxBoutonJeu.add(@boutonRecom)

			vboxBoutonJeu = Gtk::Box.new(Gtk::Orientation::VERTICAL)
				vboxBoutonJeu.valign = Gtk::Align::START
				#vboxGauche.homogeneous = true
	        vboxBoutonJeu.add(@boutonAnnulHypo)
					vboxBoutonJeu.add(@boutonValidHypo)
					vboxBoutonJeu.add(@boxMessage)
					vboxBoutonJeu.add(@boutonErreur)
	        vboxBoutonJeu.add(@boutonAideTxt)
					vboxBoutonJeu.add(@boutonAideVisu)

	    vboxGauche = Gtk::Box.new(Gtk::Orientation::VERTICAL)
				vboxGauche.valign = Gtk::Align::START
				#vboxGauche.homogeneous = true
	        vboxGauche.add(hboxBoutonRetour)
	        vboxGauche.add(hboxBoutonJeu)
					#vboxGauche.add(vboxBoutonJeu)

	    hboxChrono = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
				hboxChrono.halign = Gtk::Align::CENTER
				#hboxChrono.homogeneous = true
	        hboxChrono.add(@boxChrono)

	    hpaned = Gtk::Paned.new(Gtk::Orientation::HORIZONTAL)
	    hboxJeu = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
				hboxJeu.halign = Gtk::Align::CENTER
				#hboxJeu.homogeneous = true
	        # hboxJeu.add(@boxJeu) #<=======

	        hpaned.add(@darea) #<=======
	        hpaned.signal_connect("button-press-event") { |widget, event| mouseClick(event) }

	        #hboxJeu.add(hpaned)


	    # vboxDroite = Gtk::Box.new(Gtk::Orientation::VERTICAL)
			# 	vboxDroite.valign = Gtk::Align::FILL
			# 	#vboxDroite.homogeneous = true
	    #     vboxDroite.add(hboxChrono)

	    hboxPrincipale = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
				hboxPrincipale.halign = Gtk::Align::START
				hboxPrincipale.homogeneous = true
	    # @boutonRetour.width_request = 150
	        # hboxPrincipale.add(vboxGauche)
	        # hboxPrincipale.add(vboxDroite)
					boxVide = Gtk::Box.new(Gtk::Orientation::VERTICAL)
						boxVide.valign = Gtk::Align::START
						boxVide.homogeneous = true

						puts @longueur.to_s

	    tbl = Gtk::Table.new(1,6)
	    tbl.attach(vboxGauche,0,3,0,3)
			tbl.attach(vboxBoutonJeu,0,3,3,6)
			tbl.attach(hboxChrono,4,@longueur,0,1)
	    tbl.attach(hpaned,4,@longueur+2,1,@largeur+10)
			tbl.attach(boxVide,@longueur,@longueur+2,0,20)

			# @@fenetre.remove(@@fenetre.child)
			# @@fenetre.add(tbl)

			@@fenetre.changerWidget(tbl)

			#hpaned.signal_connect("button-press-event") { |widget, event| mouseClick(event) }
			#self.add(vbox)
			#@@fenetre.add(hpaned)

			#
			# # boxTest = Gtk::Box.new(Gtk::Orientation::VERTICAL)
			# # boxTest.add(tbl)
			# # self.add(boxTest)
			# #self.add(hboxPrincipale)
			#


			#self.add(vbox)

			@@fenetre.show_all

		self.show_all
		@@fenetre.show_all
		masquerBouton

		Gtk.main

	end

	def mouseClick(event)
		# copie tracerGrille
		paddingX = 25
		paddingY = 25
		@nbClick += 1

		x = event.x
		y = event.y

		if(!grilleGagnante)
			if(x > paddingX && x < paddingX+@tailleCase*@longueur && y > paddingY && y < paddingY+@tailleCase*@largeur) #si dans la grille
				caseX = (x - paddingX).to_i/@tailleCase
				caseY = (y -paddingY).to_i/@tailleCase
				#puts "vous avez cliqué sur la case ["+caseX.to_s+"]["+caseY.to_s+"]"

				caseTest = @grilleTest.getCase(caseX,caseY)


				# sensé regarder le contenu de la case mais PROBLEME car toutes les cases sont des sommets !
				caseTest = @grilleTest.getCase(caseX,caseY)
				caseSom = nil
				if(estSommet?(caseTest))
					puts "nb voisins du sommet : " + caseTest.contenu.compterVoisins().to_s()
					#puts "C'est un sommet"
					#afficheSurbri
					videSurbri
					@caseSom = @grilleTest.getCase(caseX,caseY)

					listV = rechercherVoisins(caseTest)
					listV.each { |v|
						if(@grilleTest.estArete(caseTest.contenu, v.contenu))
							@listeInter += getlisteInterCase(caseTest,v)
							@listeInter.push("|")
						end
						if(!caseTest.contenu.complet && !v.contenu.complet)
							@listeInter += getlisteInterCase(caseTest,v)
							@listeInter.push("|")
						end
					}
					# @listeInter += getlisteInterCase(caseTest,v)
					# @listeInter.push("|")
					#puts "AFFICHAGE DE LA LISTE:"
					#afficheSurbri()

					@listeInter.each { |c|
						#puts c.to_s
						if(c != "|" && c.class != Sommet) #<==== FAUX
							c.surbrillance = true
							#puts "\t CASE "+c.to_s+" mis en surbrillance :"+c.surbrillance.to_s
						end
					}
				end

				if(caseTest.surbrillance && caseTest.class != Sommet) # si la case est en surbrillance
					# puts "La case est en SURBRILLANCE"
					if(caseTest.contenu.class == Arete)
						s1 = caseTest.contenu.sommet1
						s2 = caseTest.contenu.sommet2

						# puts "s1=>"+s1.to_s
						# puts "s2=>"+s2.to_s

						if(event.button == 1)
							creationArete(s1,s2,caseTest.contenu)
						# testAffichageGrille

						elsif (event.button == 3)
							#puts "click droit "+event.button.to_s
							#puts "SUPPRESSION ARETE"
							suppressionArete(caseTest.contenu)

						else
							#puts "click :"+event.button.to_s
						end
					else
						#puts "la case est une case vide"


						if(event.button == 1 && caseTest.contenu.class != Sommet && caseTest.contenu.class != Arete)
							# puts "la case n'est pas un sommet"
							s1 = nil
							s2 = nil
							trouve1 = false
							@listeInter.each_with_index do |c,i|
								#puts "==tour de boucle 1==="
								if(c == caseTest)
									#puts "\tTROUVE !!!"+i.to_s+" ici"
									s1 = @listeInter[0]
									i.upto(@listeInter.length-1) do |y|
										#puts "====recherche s2 ... ===="+@listeInter[y].to_s


										if(@listeInter[y] != "|")
											if(@listeInter[y].contenu.class == Sommet)

												if(!trouve1)
													#puts "T1"
													s2 = @listeInter[y]
													trouve1 = true
												end

											end
										end
									end
									if(s1 != nil && s2 != nil)
										#puts "---"+s1.to_s
										#puts "valeur "+s1.contenu.valeur.to_s
										#puts "---"+s2.to_s
										#puts "valeur "+s2.contenu.valeur.to_s
									end





								end
							end

							caseTest = @grilleTest.getCase(caseX,caseY)
							# puts "case=>"+caseTest.contenu.class.to_s
							# puts "s1=>"+s1.contenu.to_s
							# puts "s2=>"+s2.contenu.to_s

							if(s1 != nil && caseTest.contenu.class != Sommet)
								# puts "je rentre dans la condition"
								creationArete(s1.contenu,s2.contenu,caseTest.contenu)
							end
								#puts "je sort de la condition"
						#puts "FIN @crEATION ARETE..."
						end
					end
				else

					#puts "LA CASE N'EST PAS SURBRI"
					videSurbri

				end

				afficheEcran()

			end
		end
		if(grilleGagnante && !@hypothese)
			puts "VOUS AVEZ GAGNÉ !!!!"
			@chr.arreter
			@@fenetre.changerWidget(FenetreVictoire.new(@@fenetre,@chr.to_chrono))
		end

	end

	def retirerContenu(box,contenu)
		if(contenu != nil)
			box.remove(contenu)
		end
	end

	def ajouterContenu(box,contenu)
		box.add(contenu)
	end

	def ajouterImage(contenu,image)
		image = dimImage(image)
		contenu.image=(image)
	end

	#créé une arete si les sommets ne sont pas complet
	def creationArete(s1,s2,caseT, actionAnnule = false)

		if(s1.valeur > s1.compterArete && s2.valeur > s2.compterArete)#le sommet est complet

			if(caseT.class == Arete && !caseT.estDouble)
				if(!actionAnnule)
					caseT.estDouble = true;
					caseT.hypothese = @hypothese
					@grilleTest.undo.empile(caseT)
					@grilleTest.undo.empile("CREATION")
				else
					trouve = false
					@grilleTest.aretes.each do |a|
						if(a == caseT)
							trouve = true
						end
					end
					if(trouve)
						caseT.estDouble = true;
					else
						newA = Arete.creer(s1,s2) #<================ a voir
						newA.hypothese = @hypothese
						@grilleTest.undo.empile(newA)
						@grilleTest.undo.empile("CREATION")
					end
				end
			elsif(caseT.class != Arete)
				newA = Arete.creer(s1,s2) #<================ a voir
				newA.hypothese = @hypothese
				if(!actionAnnule)
					@grilleTest.undo.empile(newA)
					@grilleTest.undo.empile("CREATION")
				end
			end
		end
		if(s1.valeur == s1.compterArete)
			#puts "SOMMET S1 COMPLET !"
			s1.complet = true
			#puts "le sommet s1"+s1.to_s+" est complet"
		end
		if(s2.valeur == s2.compterArete)
			#puts "SOMMET S2 COMPLET !"
			s2.complet = true
			#puts "le sommet s2"+s1.to_s+" est complet"
		end

		# puts "Affichage Hypo"
		# @pileUndo.tabAction.each do |a|
		# 	puts a.to_s
		# end
		# puts "===="

		# if(grilleGagnante && !@hypothese)
    #   puts "vous avez gagné"
		# 	@@fenetre.changerWidget(FenetreVictoire.new(@@fenetre))
		# end

	end

	def suppressionArete(arete, actionAnnule = false)
		if(!actionAnnule)
			@grilleTest.undo.empile(arete)
			@grilleTest.undo.empile("SUPPRESSION")
		end
		arete.sommet1.complet = false
		arete.sommet2.complet = false
		if(arete.estDouble)
			arete.estDouble = false
			if(@hypothese)
				arete.hypothese = true
			end
		else
			arete.supprimer
		end
	end

	attr_accessor :nbClick, :listeInter, :caseSom

	def drawSurbri()
		# exemple 5 5
		paddingX = 25
		paddingY = 25
		#@cr = @darea.window.create_cairo_context

		x1 = nil
		x2 = nil
		y1 = nil
		y2 = nil

		@cr.set_source_rgb 0.9, 1, 0

		@listeInter.each { |c|
			if(c == "|")

				#puts "\tX1 = "+x1.to_s+" Y1 = "+y1.to_s+" X2 = "+x2.to_s+" Y2 = "+y2.to_s
				if(x1 < x2 || caseSom.x < x1)
					# case @difficulte
					# 	when "easy"
					# 		@cr.rectangle x1*@tailleCase+paddingX-3+@tailleCase, y1*@tailleCase+paddingY+13, (x2-x1)*@tailleCase-@tailleCase+8, (y2-y1)*@tailleCase+22
					# 	when "normal"
					# 		@cr.rectangle x1*@tailleCase+paddingX-3+@tailleCase, y1*@tailleCase+paddingY+11, (x2-x1)*@tailleCase-@tailleCase+8, (y2-y1)*@tailleCase+22
					# 	when "hard"
					# 		@cr.rectangle x1*@tailleCase+paddingX-3+@tailleCase, y1*@tailleCase+paddingY+8, (x2-x1)*@tailleCase-@tailleCase+8, (y2-y1)*@tailleCase+22
					# 	else
					# end
					@cr.rectangle(x1 * @tailleCase + paddingX + @tailleCase, y1 * @tailleCase + paddingY + (@tailleCase / 2) - @largeurSurbri / 2, (x2 - x1) * @tailleCase - @tailleCase, (y2 - y1) * @tailleCase + @largeurSurbri)

				elsif(x1 > x2 || caseSom.x > x1)
					# case @difficulte
					# 	when "easy"
					# 		@cr.rectangle x1*@tailleCase+paddingX+5, y1*@tailleCase+paddingY+13, (x2-x1)*@tailleCase-8+@tailleCase, (y2-y1)*@tailleCase+22
					# 	when "normal"
					# 		@cr.rectangle x1*@tailleCase+paddingX+5, y1*@tailleCase+paddingY+11, (x2-x1)*@tailleCase-8+@tailleCase, (y2-y1)*@tailleCase+22
					# 	when "hard"
					# 		@cr.rectangle x1*@tailleCase+paddingX+5, y1*@tailleCase+paddingY+8, (x2-x1)*@tailleCase-8+@tailleCase, (y2-y1)*@tailleCase+22
					# 	else
					# end
					@cr.rectangle(x1 * @tailleCase + paddingX, y1 * @tailleCase + paddingY + (@tailleCase / 2) - @largeurSurbri / 2, (x2 - x1) * @tailleCase + @tailleCase, (y2 - y1) * @tailleCase + @largeurSurbri)
				elsif(y1 < y2 || caseSom.y < y1)
					# case @difficulte
					# 	when "easy"
					# 		@cr.rectangle x1*@tailleCase+paddingX+15, y1*@tailleCase+paddingY-5+@tailleCase, (x2-x1)*@tailleCase+22, (y2-y1)*@tailleCase-@tailleCase+8
					# 	when "normal"
					# 		@cr.rectangle x1*@tailleCase+paddingX+11, y1*@tailleCase+paddingY-5+@tailleCase, (x2-x1)*@tailleCase+22, (y2-y1)*@tailleCase-@tailleCase+8
					# 	when "hard"
					# 		@cr.rectangle x1*@tailleCase+paddingX+9, y1*@tailleCase+paddingY-5+@tailleCase, (x2-x1)*@tailleCase+22, (y2-y1)*@tailleCase-@tailleCase+8
					# 	else
					# end
					@cr.rectangle(x1 * @tailleCase + paddingX + (@tailleCase / 2) - @largeurSurbri / 2, y1 * @tailleCase + paddingY + @tailleCase, (x2 - x1) * @tailleCase + @largeurSurbri, (y2 - y1) * @tailleCase - @tailleCase)
				else
					# case @difficulte
					# 	when "easy"
					# 		@cr.rectangle x1*@tailleCase+paddingX+15, y1*@tailleCase+paddingY+5, (x2-x1)*@tailleCase+22, (y2-y1)*@tailleCase-8+@tailleCase
					# 	when "normal"
					# 		@cr.rectangle x1*@tailleCase+paddingX+11, y1*@tailleCase+paddingY+5, (x2-x1)*@tailleCase+22, (y2-y1)*@tailleCase-8+@tailleCase
					# 	when "hard"
					# 		@cr.rectangle x1*@tailleCase+paddingX+9, y1*@tailleCase+paddingY+5, (x2-x1)*@tailleCase+22, (y2-y1)*@tailleCase-8+@tailleCase
					# 	else
					# end
					@cr.rectangle(x1 * @tailleCase + paddingX + (@tailleCase / 2) - @largeurSurbri / 2, y1 * @tailleCase + paddingY, (x2 - x1) * @tailleCase + @largeurSurbri, (y2 - y1) * @tailleCase + @tailleCase)
				end
				#puts "+ ==== +"
				x1 = nil
				y1 = nil
			else
				if(x1 == nil)
					x1 = c.x
					y1 = c.y
				end
				x2 = c.x
				y2 = c.y

			end

		}
		@cr.fill
		@cr.set_source_rgb 0,0,0
		@cr.stroke_preserve

	end

	def afficheSurbri()
		@listeInter.each do |c|
			print "LISTE INTER : "+c.to_s
			if(c != "|")
				print c.surbrillance.to_s
			end

		end
	end

	def nbAretesSommet(s)
		i = 0
		s.listeArete.each {|a|
			if(a.estDouble)
				i+=2
			else
				i+=1
			end
		}
		return i
	end

	def rechercherVoisins(c)
		#puts "recherche des voisins ..."
		paddingX = 50
		paddingY = 25
		j = 0
		listeVoisin = []
		selfArete = false
		listeA = c.contenu.listeArete
		#puts c.contenu.class
		#listeA.each {|a| puts "arete ===> "+a.to_s}

		# OUEST
		(c.x-1).downto 0 do |i|
			j+=1
			#puts "test de la case ["+(c.x-j).to_s+"]["+c.y.to_s+"] i = "+j.to_s
			caseTest = @grilleTest.getCase(c.x-j,c.y)
			if(caseTest.contenu.class == Arete)
				listeA.each do |a|
					#puts "1111111111111111111"
					if(a == caseTest.contenu)
						#puts "1 - selfArete !!!!! "
						selfArete = true
					end
				end
				if(!selfArete)
					#puts "INTERSECTION"
					break
				end
			elsif(estSommet?(caseTest))
				#puts "voisin trouvé à gauche"
				listeVoisin.push(caseTest)
				break
			end
		end
		j = 0
		selfArete = false

		# EST
		(c.x+1).upto @longueur-1 do |i|
			j+=1
			#puts "test de la case ["+(c.x+j).to_s+"]["+c.y.to_s+"] i = "+j.to_s
			caseTest = @grilleTest.getCase(c.x+j,c.y)
			if(caseTest.contenu.class == Arete)
				listeA.each do |a|
					#puts "22222222222222"
					if(a == caseTest.contenu)
						#puts "2 - selfArete !!!!! "
						selfArete = true
					end
				end
				if(!selfArete)
					#puts "INTERSECTION"
					break

				end
			elsif(estSommet?(caseTest))
				#puts "voisin trouvé à droite"
				listeVoisin.push(caseTest)
				break
			end
		end
		j = 0
		selfArete = false
		# NORD
		(c.y-1).downto 0 do |i|
			j+=1
			#puts "test de la case ["+c.x.to_s+"]["+(c.y-j).to_s+"] i = "+j.to_s
			caseTest = @grilleTest.getCase(c.x,c.y-j)
			if(caseTest.contenu.class == Arete)
				listeA.each do |a|
					#puts "3333333333333333333"
					if(a == caseTest.contenu)
						#puts "3 - selfArete !!!!! "
						selfArete = true
					end
				end
				if(!selfArete)
					#puts "INTERSECTION"
					selfArete = false
					break

				end
			elsif(estSommet?(caseTest))
				#puts "voisin trouvé en haut"
				listeVoisin.push(caseTest)
				break
			end
		end
		j = 0
		selfArete = false
		# # SUD
		(c.y+1).upto @largeur-1 do |i|
			j+=1
			#puts "test de la case ["+c.x.to_s+"]["+(c.y+j).to_s+"] i = "+j.to_s
			caseTest = @grilleTest.getCase(c.x,c.y+j)
			if(caseTest.contenu.class == Arete)
				listeA.each do |a|
					#puts "4444444444444444444444"
					if(a == caseTest.contenu)
						#puts "4 - selfArete !!!!! "
						selfArete = true
					end
				end
				if(!selfArete)
					#puts "INTERSECTION"
					break

				end
			elsif(estSommet?(caseTest))
				#puts "voisin trouvé en bas"
				listeVoisin.push(caseTest)
				break
			end
		end

		return listeVoisin

	end

	# retourne la liste des cases comprises entre deux voisins
	def getlisteInterCase(s1, s2)
		x1 = s1.x
		y1 = s1.y
		x2 = s2.x
		y2 = s2.y
		listeDeCase = []
		listeDeCase.push(s1)
		# testAffichageCoord(s1)
		# testAffichageCoord(s2)
		ecart = 0
		if(x1 < x2)
			#puts "x1<x2"
			ecart = x2-(x1)
			#puts ecart.to_s
			(x1+1).upto(x2-1) {|i|
				listeDeCase.push(@grilleTest.getCase(i,y1))
			}
		elsif(x2 < x1)
			#puts "x1>x2"
			(x1-1).downto(x2+1) {|i|
				listeDeCase.push(@grilleTest.getCase(i,y1))
			}
		elsif( y1 < y2)
			#puts "y1<y2"
			(y1+1).upto(y2-1) {|i|
				listeDeCase.push(@grilleTest.getCase(x1,i))
			}
		else

			#puts "y1>y2"
			(y1-1).downto(y2+1) {|i|
				listeDeCase.push(@grilleTest.getCase(x1,i))
			}
		end

		#puts "la liste des cases en surbrillance est"
		#listeDeCase.each {|c| #puts c.x.to_s + " "+c.y.to_s}
		#puts "======"
		listeDeCase.push(s2)
		return listeDeCase
	end

	def videSurbri
		#afficheSurbri
		@listeInter.each {|c|
			#print "Une case=>"
			if(c.class == Case)
				c.surbrillance = false
				#puts "\t CASE "+c.to_s+" mis en desurbrillance :"+c.surbrillance.to_s+"==="
			end
			#@listeInter.delete_at(@listeInter.index(c))
		}
		@listeInter = []
		#puts "===FINTER====="
	end

	def grilleGagnante
		complet = true
		if(@grilleTest.testHamilton)
			@grilleTest.sommets.each do |s|
				if(!s.complet)
					complet = false
				end
			end
		else
			complet = false
		end
		return complet
	end


	def estSommet?(c)
		@grilleTest.sommets.each do |s|
			if(s.position.x == c.x && s.position.y == c.y)
				return true
			end
		end
		return false
	end

	def tracerGrille(tracer=false)
		# exemple 5 5
		paddingX = 25
		paddingY = 25

		if(tracer)
			0.upto @longueur do |i|
				draw_maLigne(i*@tailleCase+paddingX,paddingY,i*@tailleCase+paddingX,@largeur*@tailleCase+paddingY)
			end
			0.upto @largeur do |i|
				draw_maLigne(paddingX,i*@tailleCase+paddingY,@longueur*@tailleCase+paddingX,i*@tailleCase+paddingY)
			end
		end
	end

	def annulerAction()

		action = @grilleTest.undo.depile
		arete = @grilleTest.undo.depile
		if(action != nil)
			s1 = arete.sommet1
			s2 = arete.sommet2

			case(action)
			when "SUPPRESSION"
				creationArete(s1,s2,arete,true)
			when "CREATION"
				suppressionArete(arete,true)
			end
			afficheEcran()
		end
	end

	def dimImage(str)
		image = Gtk::Image.new(str)
		image.pixbuf = image.pixbuf.scale(35,35) if image.pixbuf!=nil
		return image
	end


	# def init_ui
	#
	# 		@darea = Gtk::DrawingArea.new
	#
	# 		@darea.signal_connect "draw" do
	# 				on_draw
	# 		end
	# 		add @darea
	# end

	def on_draw
			@cr = @darea.window.create_cairo_context
			afficheEcran()
	end

	attr_accessor :cr

	def draw_colors

			@cr.set_source_rgb 0.2, 0.23, 0.9
			@cr.move_to 10, 10
			@cr.line_to 150, 15
			@cr.move_to 150, 30
			@cr.stroke

			@cr.set_source_rgb 0.9, 0.1, 0.1
			@cr.rectangle 130, 15, 90, 60
			@cr.fill

			@cr.set_source_rgb 0.4, 0.9, 0.4
			@cr.rectangle 250, 15, 90, 60
			@cr.fill
	end

	def drawSommets()
		# copie de tracerGrille

		paddingX = 25 + @tailleCase / 2#25+17
		paddingY = 25 + @tailleCase / 2#25+35
		ajustementChiffreAxeX = 3
		#@cr = @darea.window.create_cairo_context

			@cr.set_font_size(@fontSize)
			@cr.set_source_rgb 0,0,0
			i = 0
			j = 0
			taillePix = 25
			padding = 20
		@grilleTest.sommets.each{ |s|
			@cr.save()
			x = s.position.x
			y = s.position.y
			if(s.complet)
				# case @difficulte
				# 	when "easy"
				# 		draw_maLigne(x*@tailleCase+paddingX-6 ,y*@tailleCase+paddingY+2,x*@tailleCase+paddingX+20 ,y*@tailleCase+paddingY-25)
				# 	when "normal"
				# 		draw_maLigne(x*@tailleCase+paddingX-7 ,y*@tailleCase+paddingY-2,x*@tailleCase+paddingX+16 ,y*@tailleCase+paddingY-27)
				# 	when "hard"
				# 		draw_maLigne(x*@tailleCase+paddingX-8 ,y*@tailleCase+paddingY-5,x*@tailleCase+paddingX+15 ,y*@tailleCase+paddingY-25)
				# 	else
				#
				# end
				draw_maLigne((x * @tailleCase + paddingX) + @tailleCercle * Math::cos(3 * Math::PI / 4),
										 (y * @tailleCase + paddingY) + @tailleCercle * Math::sin(3 * Math::PI / 4),
										 (x * @tailleCase + paddingX) + @tailleCercle * Math::cos(7 * Math::PI / 4),
										 (y * @tailleCase + paddingY) + @tailleCercle * Math::sin(7 * Math::PI / 4))
				Math::PI

			end
			if(@afficherErreur)
				@erreurs.each do |e|
					if(e == s)
						@cr.set_source_rgb 1,0,0
					end
				end
			elsif(@caseAide != nil && s.position == @aide.getCaseAide)
				@cr.set_source_rgb 0,1,0
			end

			@cr.move_to(x * @tailleCase + paddingX + @tailleCercle, y * @tailleCase + paddingY)
			@cr.arc(x * @tailleCase + paddingX, y * @tailleCase + paddingY, @tailleCercle, 0, 2 * Math::PI)
			@cr.move_to(x * @tailleCase + (paddingX + ajustementChiffreAxeX) - @tailleCercle / 2, y * @tailleCase + paddingY + @tailleCercle / 2)

			@cr.show_text(s.valeur.to_s)

			@cr.stroke_preserve
			@cr.set_source_rgb 0,0,0

			i+=1
			j+=1

		}
	end

	def drawAretes()
		# copie de tracerGrille
		paddingX = 25
		paddingY = 25
		verti = false
		decalageDoubleArete = 3
		#@cr = @darea.window.create_cairo_context

		@cr.set_source_rgb 0,0,0

		@grilleTest.aretes.each{ |a|
			activeHypo(a.hypothese)

			x1 = a.sommet1.position.x
			y1 = a.sommet1.position.y
			x2 = a.sommet2.position.x
			y2 = a.sommet2.position.y
			if(x1 == x2)
				verti = true
			else
				verti = false
			end

			if(!a.estDouble)# || 1)
				case verti
				when true
					if(y1 < y2)
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase / 2, y1 * @tailleCase + paddingY + @tailleCase)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase / 2, y2 * @tailleCase + paddingY)
						@cr.stroke()
					else
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase / 2, y1 * @tailleCase + paddingY)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase / 2, y2 * @tailleCase + paddingY + @tailleCase)
						@cr.stroke()
					end
				when false
					if(x1 < x2)
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase, y1 * @tailleCase + paddingY + @tailleCase / 2)
						@cr.line_to(x2 * @tailleCase + paddingX, y2 * @tailleCase + paddingY + @tailleCase / 2)
						@cr.stroke()
					else
						@cr.move_to(x1 * @tailleCase + paddingX, y1 * @tailleCase + paddingY + @tailleCase / 2)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase, y2 * @tailleCase + paddingY + @tailleCase / 2)
						@cr.stroke()
					end
				end
			else
				case verti
				when true
					if(y1 < y2)
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase / 2 - decalageDoubleArete, y1 * @tailleCase + paddingY + @tailleCase)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase / 2 - decalageDoubleArete, y2 * @tailleCase + paddingY)
						@cr.stroke()
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase / 2 + decalageDoubleArete, y1 * @tailleCase + paddingY + @tailleCase)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase / 2 + decalageDoubleArete, y2 * @tailleCase + paddingY)
						@cr.stroke()
					else
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase / 2 - decalageDoubleArete, y1 * @tailleCase + paddingY)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase / 2 - decalageDoubleArete, y2 * @tailleCase + paddingY + @tailleCase)
						@cr.stroke()
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase / 2 + decalageDoubleArete, y1 * @tailleCase + paddingY)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase / 2 + decalageDoubleArete, y2 * @tailleCase + paddingY + @tailleCase)
						@cr.stroke()
					end
				when false
					if(x1 < x2)
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase, y1 * @tailleCase + paddingY + @tailleCase / 2 - decalageDoubleArete)
						@cr.line_to(x2 * @tailleCase + paddingX, y2 * @tailleCase + paddingY + @tailleCase / 2- decalageDoubleArete)
						@cr.stroke()
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase, y1 * @tailleCase + paddingY + @tailleCase / 2 + decalageDoubleArete)
						@cr.line_to(x2 * @tailleCase + paddingX, y2 * @tailleCase + paddingY + @tailleCase / 2 + decalageDoubleArete)
						@cr.stroke()
					else
						@cr.move_to(x1 * @tailleCase + paddingX, y1 * @tailleCase + paddingY + @tailleCase / 2 - decalageDoubleArete)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase, y2 * @tailleCase + paddingY + @tailleCase / 2 - decalageDoubleArete)
						@cr.stroke()
						@cr.move_to(x1 * @tailleCase + paddingX, y1 * @tailleCase + paddingY + @tailleCase / 2 + decalageDoubleArete)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase, y2 * @tailleCase + paddingY + @tailleCase / 2 + decalageDoubleArete)
						@cr.stroke()
					end
				end
			end
		}
	end

	def draw_maLigne(x1,y1,x2,y2)
		@cr.move_to x1, y1
		@cr.line_to x2,y2
		@cr.stroke_preserve
	end

	def activeHypo(condition = false)
		if(condition)
			@cr.set_dash(5, 15)
			#@cr.set_source_rgb 1,0,0
		else
			@cr.restore()
		end
	end

	def testAffichageGrille
		puts "=====TEST====="
		@grilleTest.aretes.each {|a|
			puts a.to_s
		}
		@grilleTest.sommets.each {|s|
			puts s.to_s
		}
		puts "=====FTEST====="

	end

	def testAffichageCoord(c)
		puts "=====TEST COORD====="
		puts "La Case est en\t x="+c.x.to_s+" y="+c.y.to_s
		puts "=====FTEST====="

	end

	def clearEcran()
		@cr = @darea.window.create_cairo_context
		@cr.set_source_rgb 0.96, 0.96, 0.96
		###@@fenetre.default_size == [x,y]
		if(@longueur > @largeur)
			@cr.rectangle 0, 0, @tailleArea, (((@tailleArea - 50) / @longueur) * @largeur) + 50 #<== Changer aux dimensions de la fenentre
		else
			@cr.rectangle 0, 0, (((@tailleArea - 50) / @largeur) * @longueur) + 50, @tailleArea #<== Changer aux dimensions de la fenentre
		end
		@cr.fill
		@cr.set_source_rgb 0, 0, 0
	end

	def afficheEcran()
		clearEcran()
		drawSurbri()
		tracerGrille(true) #<== AIDE VISUEL TEMPO
		drawSommets()
		drawAretes()

	end

	def initBoutonRetour
    @boutonRetour = UnBoutonPerso.new("Retour")do
			if(!@classe)
				popup = Gtk::MessageDialog.new(@@fenetre, :modal, :question, :none, "Souhaitez-vous sauvegarder la partie ? La sauvegarde précédente sera écrasée.")
				popup.add_buttons(["Sauvegarder", :yes], ["Quitter", :no], [Gtk::Stock::CANCEL, :reject])

				response = popup.run()

				if(response == :yes)
					save = Sauvegarde.nouvelle(@grilleTest, @grilleDepart, nil, @difficulte)
					save.sauvegarder()
					@@fenetre.changerWidget(FenetreMenu.new(@@fenetre))
				elsif(response == :no)
					@@fenetre.changerWidget(FenetreMenu.new(@@fenetre))
				end

				popup.destroy()
			else
				popup = Gtk::MessageDialog.new(@@fenetre, :modal, :question, :none, "Voulez vous quitter la partie classé ? Vous ne pouvez pas sauvegarder une partie classée")
				popup.add_buttons(["Continuer", :yes], ["Quitter", :no])

				@chr.arreter()
				response = popup.run()

				if(response == :no)
					popup.destroy()
					@@fenetre.changerWidget(FenetreMenu.new(@@fenetre))
				else
					popup.destroy()
					@chr.chronometrer()
				end
			end
    end
  end

  def initBoutonHypo
    @boutonHypo = UnBoutonPerso.new("H")do
      puts "j'ai cliqué sur le bouton Hypo"
			if(@presser)
				@presser = false
				@boutonAide.deverrouiller()
				@boutonRecom.deverrouiller()
				@boutonAnnul.deverrouiller()

				@grilleTest = Sauvegarde.annulerHypothese()
				@hypothese = false

				masquerBouton
			else
				@boutonAide.verrouiller()
				@boutonRecom.verrouiller()
				@boutonAnnul.verrouiller()

				@presser = true
				puts "appuie bouton Hypothèse"
				@hypothese = true

				@boutonValidHypo.show

				Sauvegarde.nouvelleHypothese(@grilleTest)
				# ajouterContenu(vbox,@boutonAnnulHypo)
				# ajouterContenu(vbox,@boutonValidHypo)

				# tbl.attach(vbox,0,1,2,10)
				#self.show_all
				@boutonAnnulHypo.show
				@boutonValidHypo.show
			end
    end
		ajouterImage(@boutonHypo,"img/cloud_icon.png")
  end

	def initBoutonAnnulHypo
    @boutonAnnulHypo = UnBoutonPerso.new("Annuler Hypothèse")do
			@presser = false

			@grilleTest = Sauvegarde.annulerHypothese()
			@hypothese = false

			@boutonAide.deverrouiller()
			@boutonRecom.deverrouiller()
			@boutonAnnul.deverrouiller()

			# retirerContenu(vbox,@boutonAnnulHypo)
			# retirerContenu(vbox,@boutonValidHypo)

			afficheEcran
			masquerBouton
			# self.show_all
    end
  end

	def initBoutonValidHypo
    @boutonValidHypo= UnBoutonPerso.new("Valider Hypothèse")do
			@presser = false

			Sauvegarde.validerHypothese()
			@hypothese = false
			@grilleTest.aretes.each do |a|
				a.hypothese = @hypothese
			end
			@boutonAide.deverrouiller()
			@boutonRecom.deverrouiller()
			@boutonAnnul.deverrouiller()


			# retirerContenu(vbox,@boutonAnnulHypo)
			# retirerContenu(vbox,@boutonValidHypo)
			masquerBouton
    end
			@boutonValidHypo.hide
  end



  def initBoutonAide
		@boxMessage = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
		@boxMessage.halign = Gtk::Align::CENTER
    		@boutonAide = UnBoutonPerso.new("?")do
			@erreurs = nil
			@afficherErreur = false
			@erreurs = @gene.trouverErreurs(@grilleTest)

			# retirerContenu(vbox,@boutonAideVisu)



			if(@presser)

				# if(@erreurs != nil && @erreurs.size != 0)
				# 	@labelMessage = UnLabelPerso.new("Vous avez "+@erreurs.size().to_s+" erreur(s)")
				#
				# 	masquerBouton()
				# 	@labelMessage.show
				# 	# ajouterMessage(vbox,messageLabel)
				# 	# ajouterContenu(vbox,btnErreurVisu)
				# else
				#
				# 	@afficherErreur = false
				#
				# 	# ajouterContenu(vbox,@boutonAideTxt)
				# 	# ajouterContenu(vbox,@boutonAideVisu)
				# end

				# @aide = Aide.creer(@grilleTest)


				@presser = false
				@boutonHypo.deverrouiller()
				@boutonRecom.deverrouiller()
				@boutonAnnul.deverrouiller()
				masquerBouton
				# retirerContenu(vbox,messageLabel)
				#retirerContenu(@boxMessage,@aideTxt)
				# retirerContenu(vbox,@boutonAideVisu)

			else

				puts "je viens d'appuyer sur le bouton"
				@presser = true
				if(@aide == nil)
					@aide = Aide.creer(@grilleTest)
				end
				@boutonHypo.verrouiller()
				@boutonRecom.verrouiller()
				@boutonAnnul.verrouiller()
				# tbl.attach(vbox,0,1,2,10)
				# self.show_all
				if(@erreurs != nil && @erreurs.size != 0)
					puts "il y a 1 erreur"
					@labelMessage = UnLabelPerso.new("Vous avez "+@erreurs.size().to_s+" erreur(s)","UnLabelBlanc")
					@boxMessage.add(@labelMessage)
					masquerBouton()
					@labelMessage.show
					@boutonErreur.show
					# ajouterMessage(vbox,messageLabel)
					# ajouterContenu(vbox,btnErreurVisu)
				else

					@afficherErreur = false

					@boutonAideTxt.show
					@boutonAideVisu.show

					# ajouterContenu(vbox,@boutonAideTxt)
					# ajouterContenu(vbox,@boutonAideVisu)
				end

			end
    end
  end


	def initLabelMessage
    @labelMessage = UnLabelPerso.new("test blanc", "UnLabelBlanc")
  end


	def initBoutonErreurVisu
    @boutonErreur = UnBoutonPerso.new("Montrer les erreurs ?")do
			puts "appuie bouton Erreur Visu"
			@afficherErreur = true
			@erreurs = @gene.trouverErreurs(@grilleTest)
			# retirerContenu(vbox,@boutonErreur)
			# retirerContenu(vbox,messageLabel)
			afficheEcran
			masquerBouton
		end
  end

	def initBoutonAideTxt
			@boutonAideTxt = UnBoutonPerso.new("Aide Textuelle")do
			@caseA = nil
			@aideTxt = Aide.creer(@grilleTest)
			@aideTxt.set_name("UnLabelBlanc")
			retirerContenu(@boxMessage,@aideTxt)
			@boxMessage.add(@aideTxt)
			# retirerContenu(vbox,@boutonAideTxt)
			# retirerContenu(vbox,@boutonAideVisu)
			# ajouterContenu(vbox,@boutonAideVisu)
			afficheEcran()
			# self.show_all
			masquerBouton
			@aideTxt.show
		end
  end

	def initBoutonAideVisu
    @boutonAideVisu = UnBoutonPerso.new("Aide Visuelle")do
			puts "appuie bouton visuelle"
			@aide = Aide.creer(@grilleTest)

			# retirerContenu(vbox,@boutonAideTxt)
			# retirerContenu(vbox,@boutonAideVisu)
			@caseAide = @aide.getCaseAide
			afficheEcran
			masquerBouton
    end
  end

  def initBoutonAnnul
    @boutonAnnul = UnBoutonPerso.new("U")do
			# puts "appuie bouton Annuler"
			annulerAction()

    end
		ajouterImage(@boutonAnnul,"img/undo_icon2.png")
  end

  def initBoutonRecom
    @boutonRecom = UnBoutonPerso.new("R")do
			# puts "appuie bouton Recommencer"
			# @grilleTest = @grilleDepart
			@grilleTest.clearAretes
			@grilleTest.clearSommets
			@listeInter = []
			afficheEcran
    end
		ajouterImage(@boutonRecom,"img/restart_icon.png")
  end

  def initChrono
		@boxChrono = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
		@boutonSablier = UnBoutonPerso.new("","Chrono")
		@boxChrono.add(@boutonSablier)
		@boutonSablier.verrouiller()

		if(@classe)
			@chr = Chrono.nouveau()
			# tbl.attach(chronoHbox,1,3,2,4)
			@boutonSablier.show
			@boxChrono.show
			@chr.set_name("LabelChrono")
			@chr.show
			 ajouterContenu(@boxChrono,@chr)

			Thread.new {@chr.chronometrer()}

		end
		ajouterImage(@boutonSablier,"img/hourglass_icon.png")

  end

  def initBoxJeu
    @boxJeu = UnBoutonPerso.new("ceci est ma grille de Jeu")do
      @boxJeu.set_sensitive(false)
    end
  end

	def masquerBouton
		@boutonAnnulHypo.hide
		@boutonValidHypo.hide
		@labelMessage.hide
		if @aideTxt != nil
			@aideTxt.hide
		end
		@boutonErreur.hide
		@boutonAideTxt.hide
		@boutonAideVisu.hide
		@boutonSablier.hide
	end

	def initTailleCase
		# case @difficulte
		# 	when "easy"
		# 		@tailleCase = 50
		# 		@fontSize = 25
		# 		@tailleCercle = 20
		# 	when "normal"
		# 		@tailleCase = 45
		# 		@fontSize = 22
		# 		@tailleCercle = 18
		# 	when "hard"
		# 		@tailleCase = 40
		# 		@fontSize = 18
		# 		@tailleCercle = 15
		# 	else
		# 		@tailleCase = 60
		# 		@fontSize = 30
		# 		@tailleCercle = 20
		# end
		@tailleCase = (@tailleArea - 50) / (@longueur > @largeur ? @longueur : @largeur)
		@fontSize = @tailleCase / 2
		@tailleCercle = @tailleCase / 5 * 2
		@largeurSurbri = @tailleCase / 4
	end


end
