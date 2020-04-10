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
	#@style

	attr_reader :grilleTest, :longueur, :largeur

	def initialize(window,fenPre ,difficulte, classe, save = nil, long=nil, larg=nil, dens=nil, tuto = nil)
		super(Gtk::Orientation::VERTICAL)

    @@fenetre = window
		@fenPre = fenPre;
		@tailleArea = @@fenetre.default_size[1] / 20 * 13
		@tuto = tuto
    @difficulte = difficulte
		@classe = classe

		@presse = false
		@hypothese = false
		@listeInter = []
		x = 5
		y = 5

		if @@fenetre.default_size[0] > 1500
			@style = "BoutonEnJeu"
		else
			@style = "BoutonEnJeu2"
		end

		#####################################
		if(save == nil && tuto == nil)
			@gene = Generateur.new(@difficulte, long, larg, dens)
			@grilleTest = @gene.creeUneGrille()
			@grilleComplete = @gene.getGrilleAvecArete()
		elsif(tuto != nil)
			@grilleTest = tuto.lancerTuto.grille
			@grilleComplete = tuto.lancerTuto.grilleComplete
		else
			@grilleComplete = save.grilleComplete
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
	        hboxBoutonRetour.add(@boutonRetour)

	    hboxBoutonJeu = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
	  		hboxBoutonJeu.halign = Gtk::Align::START
	  		hboxBoutonJeu.homogeneous = false
	        hboxBoutonJeu.add(@boutonHypo)
	        hboxBoutonJeu.add(@boutonAide)
	        hboxBoutonJeu.add(@boutonAnnul)
	        hboxBoutonJeu.add(@boutonRecom)

			vboxBoutonJeu = Gtk::Box.new(Gtk::Orientation::VERTICAL)
				vboxBoutonJeu.valign = Gtk::Align::START
	        vboxBoutonJeu.add(@boutonAnnulHypo)
					vboxBoutonJeu.add(@boutonValidHypo)
					vboxBoutonJeu.add(@boxMessage)
					vboxBoutonJeu.add(@boutonErreur)
	        vboxBoutonJeu.add(@boutonAideTxt)
					vboxBoutonJeu.add(@boutonAideVisu)

	    vboxGauche = Gtk::Box.new(Gtk::Orientation::VERTICAL)
				vboxGauche.valign = Gtk::Align::START
	        vboxGauche.add(hboxBoutonRetour)
	        vboxGauche.add(hboxBoutonJeu)

	    hboxChrono = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
				hboxChrono.halign = Gtk::Align::CENTER
	        hboxChrono.add(@boxChrono)

	    hpaned = Gtk::Paned.new(Gtk::Orientation::HORIZONTAL)
	    hboxJeu = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
				hboxJeu.halign = Gtk::Align::FILL

	        hpaned.add(@darea) #<=======
	        hpaned.signal_connect("button-press-event") { |widget, event| mouseClick(event) }

	    hboxPrincipale = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
				hboxPrincipale.halign = Gtk::Align::START
				hboxPrincipale.homogeneous = false
					boxVide = Gtk::Box.new(Gtk::Orientation::VERTICAL)
						boxVide.valign = Gtk::Align::START
						boxVide.homogeneous = false

	    tbl = Gtk::Table.new(20, 20)
	    tbl.attach(vboxGauche, 0, 5, 0, 5, Gtk::AttachOptions::SHRINK)
			tbl.attach(vboxBoutonJeu, 0, 5, 6, 20, Gtk::AttachOptions::EXPAND)
			tbl.attach(hboxChrono, 6, 20, 0, 1, Gtk::AttachOptions::SHRINK)
	    tbl.attach(hpaned, 6, 20, 1, 20)

			@@fenetre.changerWidget(tbl)

			@@fenetre.show_all

		self.show_all
		@@fenetre.show_all
		masquerBouton
		if(tuto != nil)
			masquerAllBouton
			initBoutonTuto(tuto.niveau)
			@labelMessageTuto = UnLabelPerso.new(tuto.getMessageTuto,"UnLabelBlanc")
			retirerContenu(@boxMessage,@labelMessageTuto)
			ajouterContenu(@boxMessage,@labelMessageTuto)
			@labelMessageTuto.show
			@boxMessage.show
		end

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

				caseTest = @grilleTest.getCase(caseX,caseY)


				# sensé regarder le contenu de la case mais PROBLEME car toutes les cases sont des sommets !
				caseTest = @grilleTest.getCase(caseX,caseY)
				caseSom = nil
				if(estSommet?(caseTest))
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

					@listeInter.each { |c|
						if(c != "|" && c.class != Sommet) #<==== FAUX
							c.surbrillance = true
						end
					}
				end

				if(caseTest.surbrillance && caseTest.class != Sommet) # si la case est en surbrillance
					if(caseTest.contenu.class == Arete)
						s1 = caseTest.contenu.sommet1
						s2 = caseTest.contenu.sommet2
						if(event.button == 1)
							creationArete(s1,s2,caseTest.contenu)
						elsif (event.button == 3)
							suppressionArete(caseTest.contenu)
						end
					else
						if(event.button == 1 && caseTest.contenu.class != Sommet && caseTest.contenu.class != Arete)
							s1 = nil
							s2 = nil
							trouve1 = false
							@listeInter.each_with_index do |c,i|
								if(c == caseTest)
									s1 = @listeInter[0]
									i.upto(@listeInter.length-1) do |y|
										if(@listeInter[y] != "|")
											if(@listeInter[y].contenu.class == Sommet)
												if(!trouve1)
													s2 = @listeInter[y]
													trouve1 = true
												end
											end
										end
									end
								end
							end
							caseTest = @grilleTest.getCase(caseX,caseY)
							if(s1 != nil && caseTest.contenu.class != Sommet)
								creationArete(s1.contenu,s2.contenu,caseTest.contenu)
							end
						end
					end
				else
					videSurbri()
				end
				afficheEcran()
			end
		end
		conditionGagnante()
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
			s1.complet = true
		end
		if(s2.valeur == s2.compterArete)
			s2.complet = true
		end
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

		x1 = nil
		x2 = nil
		y1 = nil
		y2 = nil

		@cr.set_source_rgb 0.9, 1, 0

		@listeInter.each { |c|
			if(c == "|")
				if(x1 < x2 || caseSom.x < x1)
					@cr.rectangle(x1 * @tailleCase + paddingX + @tailleCase, y1 * @tailleCase + paddingY + (@tailleCase / 2) - @largeurSurbri / 2, (x2 - x1) * @tailleCase - @tailleCase, (y2 - y1) * @tailleCase + @largeurSurbri)

				elsif(x1 > x2 || caseSom.x > x1)
					@cr.rectangle(x1 * @tailleCase + paddingX, y1 * @tailleCase + paddingY + (@tailleCase / 2) - @largeurSurbri / 2, (x2 - x1) * @tailleCase + @tailleCase, (y2 - y1) * @tailleCase + @largeurSurbri)
				elsif(y1 < y2 || caseSom.y < y1)
					@cr.rectangle(x1 * @tailleCase + paddingX + (@tailleCase / 2) - @largeurSurbri / 2, y1 * @tailleCase + paddingY + @tailleCase, (x2 - x1) * @tailleCase + @largeurSurbri, (y2 - y1) * @tailleCase - @tailleCase)
				else
					@cr.rectangle(x1 * @tailleCase + paddingX + (@tailleCase / 2) - @largeurSurbri / 2, y1 * @tailleCase + paddingY, (x2 - x1) * @tailleCase + @largeurSurbri, (y2 - y1) * @tailleCase + @tailleCase)
				end
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
		@cr.stroke

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
		paddingX = 50
		paddingY = 25
		j = 0
		listeVoisin = []
		selfArete = false
		listeA = c.contenu.listeArete
		# OUEST
		(c.x-1).downto 0 do |i|
			j+=1
			caseTest = @grilleTest.getCase(c.x-j,c.y)
			if(caseTest.contenu.class == Arete)
				listeA.each do |a|
					if(a == caseTest.contenu)
						selfArete = true
					end
				end
				if(!selfArete)
					break
				end
			elsif(estSommet?(caseTest))
				listeVoisin.push(caseTest)
				break
			end
		end
		j = 0
		selfArete = false

		# EST
		(c.x+1).upto @longueur-1 do |i|
			j+=1
			caseTest = @grilleTest.getCase(c.x+j,c.y)
			if(caseTest.contenu.class == Arete)
				listeA.each do |a|
					if(a == caseTest.contenu)
						selfArete = true
					end
				end
				if(!selfArete)
					break

				end
			elsif(estSommet?(caseTest))
				listeVoisin.push(caseTest)
				break
			end
		end
		j = 0
		selfArete = false
		# NORD
		(c.y-1).downto 0 do |i|
			j+=1
			caseTest = @grilleTest.getCase(c.x,c.y-j)
			if(caseTest.contenu.class == Arete)
				listeA.each do |a|
					if(a == caseTest.contenu)
						selfArete = true
					end
				end
				if(!selfArete)
					selfArete = false
					break

				end
			elsif(estSommet?(caseTest))
				listeVoisin.push(caseTest)
				break
			end
		end
		j = 0
		selfArete = false
		# # SUD
		(c.y+1).upto @largeur-1 do |i|
			j+=1
			caseTest = @grilleTest.getCase(c.x,c.y+j)
			if(caseTest.contenu.class == Arete)
				listeA.each do |a|
					if(a == caseTest.contenu)
						selfArete = true
					end
				end
				if(!selfArete)
					break
				end
			elsif(estSommet?(caseTest))
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
			ecart = x2-(x1)
			(x1+1).upto(x2-1) {|i|
				listeDeCase.push(@grilleTest.getCase(i,y1))
			}
		elsif(x2 < x1)
			(x1-1).downto(x2+1) {|i|
				listeDeCase.push(@grilleTest.getCase(i,y1))
			}
		elsif( y1 < y2)
			(y1+1).upto(y2-1) {|i|
				listeDeCase.push(@grilleTest.getCase(x1,i))
			}
		else
			(y1-1).downto(y2+1) {|i|
				listeDeCase.push(@grilleTest.getCase(x1,i))
			}
		end
		listeDeCase.push(s2)
		return listeDeCase
	end

	def videSurbri
		#afficheSurbri
		@listeInter.each {|c|
			if(c.class == Case)
				c.surbrillance = false
			end
		}
		@listeInter = []
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

	def dimImage(file)
		image = Gtk::Image.new(:file => file)
		image.pixbuf = image.pixbuf.scale(35,35) if image.pixbuf!=nil
		return image
	end

	def on_draw
			@cr = @darea.window.create_cairo_context
			afficheEcran()
	end

	attr_accessor :cr

	def drawSommets()
		# copie de tracerGrille

		paddingX = 25 + @tailleCase / 2#25+17
		paddingY = 25 + @tailleCase / 2#25+35
		ajustementChiffreAxeX = 3

			@cr.set_font_size(@fontSize)

			i = 0
			j = 0
			taillePix = 25
			padding = 20
		@grilleTest.sommets.each{ |s|
			x = s.position.x
			y = s.position.y

			if(@afficherErreur)
				@erreurs.each do |e|
					if(e == s)
						@cr.set_source_rgb 1,0,0
					end
				end
			elsif(@caseAide != nil && s.position == @aide.getCaseAide && @afficheAide)
				@cr.set_source_rgb 0,1,0
			end

			@cr.move_to(x * @tailleCase + paddingX + @tailleCercle, y * @tailleCase + paddingY)
			@cr.arc(x * @tailleCase + paddingX, y * @tailleCase + paddingY, @tailleCercle, 0, 2 * Math::PI)
			@cr.move_to(x * @tailleCase + (paddingX + ajustementChiffreAxeX) - @tailleCercle / 2, y * @tailleCase + paddingY + @tailleCercle / 2)

			@cr.show_text(s.valeur.to_s)
			@cr.stroke

			if(s.complet)
								draw_maLigne((x * @tailleCase + paddingX) + @tailleCercle * Math::cos(3 * Math::PI / 4),
										 (y * @tailleCase + paddingY) + @tailleCercle * Math::sin(3 * Math::PI / 4),
										 (x * @tailleCase + paddingX) + @tailleCercle * Math::cos(7 * Math::PI / 4),
										 (y * @tailleCase + paddingY) + @tailleCercle * Math::sin(7 * Math::PI / 4))
				Math::PI
			end

			@cr.set_source_rgb 0,0,0
			@cr.stroke

			i+=1
			j+=1

		}
		@cr.set_source_rgb 0,0,0
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
					else
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase / 2, y1 * @tailleCase + paddingY)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase / 2, y2 * @tailleCase + paddingY + @tailleCase)
					end
				when false
					if(x1 < x2)
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase, y1 * @tailleCase + paddingY + @tailleCase / 2)
						@cr.line_to(x2 * @tailleCase + paddingX, y2 * @tailleCase + paddingY + @tailleCase / 2)
					else
						@cr.move_to(x1 * @tailleCase + paddingX, y1 * @tailleCase + paddingY + @tailleCase / 2)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase, y2 * @tailleCase + paddingY + @tailleCase / 2)
					end
				end
			else
				case verti
				when true
					if(y1 < y2)
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase / 2 - decalageDoubleArete, y1 * @tailleCase + paddingY + @tailleCase)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase / 2 - decalageDoubleArete, y2 * @tailleCase + paddingY)
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase / 2 + decalageDoubleArete, y1 * @tailleCase + paddingY + @tailleCase)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase / 2 + decalageDoubleArete, y2 * @tailleCase + paddingY)
					else
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase / 2 - decalageDoubleArete, y1 * @tailleCase + paddingY)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase / 2 - decalageDoubleArete, y2 * @tailleCase + paddingY + @tailleCase)
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase / 2 + decalageDoubleArete, y1 * @tailleCase + paddingY)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase / 2 + decalageDoubleArete, y2 * @tailleCase + paddingY + @tailleCase)
					end
				when false
					if(x1 < x2)
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase, y1 * @tailleCase + paddingY + @tailleCase / 2 - decalageDoubleArete)
						@cr.line_to(x2 * @tailleCase + paddingX, y2 * @tailleCase + paddingY + @tailleCase / 2- decalageDoubleArete)
						@cr.move_to(x1 * @tailleCase + paddingX + @tailleCase, y1 * @tailleCase + paddingY + @tailleCase / 2 + decalageDoubleArete)
						@cr.line_to(x2 * @tailleCase + paddingX, y2 * @tailleCase + paddingY + @tailleCase / 2 + decalageDoubleArete)
					else
						@cr.move_to(x1 * @tailleCase + paddingX, y1 * @tailleCase + paddingY + @tailleCase / 2 - decalageDoubleArete)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase, y2 * @tailleCase + paddingY + @tailleCase / 2 - decalageDoubleArete)
						@cr.move_to(x1 * @tailleCase + paddingX, y1 * @tailleCase + paddingY + @tailleCase / 2 + decalageDoubleArete)
						@cr.line_to(x2 * @tailleCase + paddingX + @tailleCase, y2 * @tailleCase + paddingY + @tailleCase / 2 + decalageDoubleArete)
					end
				end
			end
			activeHypo(a.hypothese)
			@cr.stroke
			@cr = @darea.window.create_cairo_context

		}
	end

	def draw_maLigne(x1,y1,x2,y2)
		@cr.move_to x1, y1
		@cr.line_to x2,y2
		@cr.stroke
	end

	def activeHypo(condition = false)
		if(condition)
			@cr.set_dash(5, 15)
		end
	end

	def clearEcran()
		@cr = @darea.window.create_cairo_context
		@cr.set_source_rgb 0.96, 0.96, 0.96
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
    @boutonRetour = UnBoutonPerso.new("Retour", @style)do
			if(@tuto)
					@@fenetre.changerWidget(@fenPre)
			elsif(!@classe)
				popup = Gtk::MessageDialog.new(:parent => @@fenetre, :flags => :modal, :type => :question, :buttons => :none, :message => "Souhaitez-vous sauvegarder la partie ? La sauvegarde précédente sera écrasée.")
				popup.add_buttons(["Sauvegarder", :yes], ["Quitter", :no], [Gtk::Stock::CANCEL, :reject])

				response = popup.run()

				if(response == :yes)
					save = Sauvegarde.nouvelle(@grilleTest, @grilleComplete, nil, @difficulte)
					save.sauvegarder()
					@@fenetre.changerWidget(@fenPre)
				elsif(response == :no)
					@@fenetre.changerWidget(@fenPre)
				end

				popup.destroy()
			else
				popup = Gtk::MessageDialog.new(:parent => @@fenetre, :flags => :modal, :type => :question, :buttons => :none, :message => "Voulez vous quitter la partie classée ? Vous ne pouvez pas sauvegarder une partie classée")
				popup.add_buttons(["Continuer", :yes], ["Quitter", :no])

				@chr.arreter()
				response = popup.run()

				if(response == :no)
					@chr.fin()
					popup.destroy()
					@@fenetre.changerWidget(@fenPre)
				else
					popup.destroy()
					@chr.chronometrer()
				end
			end
    end
  end

  def initBoutonHypo
    @boutonHypo = UnBoutonPerso.new("H", @style)do
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
				@hypothese = true

				@boutonValidHypo.show

				Sauvegarde.nouvelleHypothese(@grilleTest)
				@boutonAnnulHypo.show
				@boutonValidHypo.show
			end
    end
		ajouterImage(@boutonHypo,"#{$cheminRacineHashi}/Interface/img/cloud_icon.png")
  end

	def initBoutonAnnulHypo
    @boutonAnnulHypo = UnBoutonPerso.new("Annuler Hypothèse", "BoutonEnJeuGros")do
			@presser = false

			@grilleTest = Sauvegarde.annulerHypothese()
			@hypothese = false

			@boutonAide.deverrouiller()
			@boutonRecom.deverrouiller()
			@boutonAnnul.deverrouiller()
			afficheEcran
			masquerBouton
    end
  end

	def initBoutonValidHypo
    @boutonValidHypo= UnBoutonPerso.new("Valider Hypothèse", @style)do
			@presser = false
			Sauvegarde.validerHypothese()
			@hypothese = false
			@grilleTest.aretes.each do |a|
				a.hypothese = @hypothese
			end
			@boutonAide.deverrouiller()
			@boutonRecom.deverrouiller()
			@boutonAnnul.deverrouiller()
			masquerBouton
			conditionGagnante
    end
			@boutonValidHypo.hide
  end

  def initBoutonAide
		@boxMessage = Gtk::Box.new(Gtk::Orientation::VERTICAL)
		@boxMessage.valign = Gtk::Align::CENTER
    		@boutonAide = UnBoutonPerso.new("?", @style)do
			@erreurs = nil
			@afficheAide = false
			@afficherErreur = false
			@erreurs = @grilleTest.trouverErreurs(@grilleComplete)
			if(@presser)
				@afficheAide = false
				@presser = false
				@boutonHypo.deverrouiller()
				@boutonRecom.deverrouiller()
				@boutonAnnul.deverrouiller()
				masquerBouton
				afficheEcran
			else
				@presser = true
				@boutonHypo.verrouiller()
				@boutonRecom.verrouiller()
				@boutonAnnul.verrouiller()
				if(@erreurs != nil && @erreurs.size != 0)
					@labelMessage = UnLabelPerso.new("Vous avez "+@erreurs.size().to_s+" erreur(s)","UnLabelBlanc")
					ajouteMalus(5)
					retirerContenu(@boxMessage,@labelMessage)
					@boxMessage.add(@labelMessage)
					masquerBouton()
					@labelMessage.show
					@boutonErreur.show
				else
					@afficherErreur = false
					@boutonAideTxt.show
					@boutonAideVisu.show
				end
			end
    end
		ajouterImage(@boutonAide,"#{$cheminRacineHashi}/Interface/img/help_icon.png")
  end


	def initLabelMessage
    @labelMessage = UnLabelPerso.new("", "UnLabelBlanc")
  end


	def initBoutonErreurVisu
    			@boutonErreur = UnBoutonPerso.new("Montrer les erreurs ?", "BoutonEnJeuGros")do
			@afficherErreur = true
			@erreurs = @grilleTest.trouverErreurs(@grilleComplete)

			ajouteMalus(15)
			afficheEcran
			masquerBouton
		end
  end

	def initBoutonAideTxt
			@boutonAideTxt = UnBoutonPerso.new("Aide Textuelle", "BoutonEnJeuGros")do
			@caseA = nil
			@aideTxt = Aide.creer(@grilleTest)
			@aideTxt.set_name("UnLabelBlanc")
			retirerContenu(@boxMessage,@aideTxt)
			@boxMessage.add(@aideTxt)
			afficheEcran()
			masquerBouton

			ajouteMalus(@aideTxt.penalite)
			@aideTxt.show
		end
  end

	def initBoutonAideVisu
   			@boutonAideVisu = UnBoutonPerso.new("Aide Visuelle", "BoutonEnJeuGros")do
			@aide = Aide.creer(@grilleTest)
			@afficheAide = true
			@caseAide = @aide.getCaseAide
			ajouteMalus(@aide.penalite)
			afficheEcran
			masquerBouton
    end
  end

  def initBoutonAnnul
    @boutonAnnul = UnBoutonPerso.new("U", @style)do
			annulerAction()
    end
		ajouterImage(@boutonAnnul,"#{$cheminRacineHashi}/Interface/img/undo_icon2.png")
  end

  def initBoutonRecom
    @boutonRecom = UnBoutonPerso.new("R", @style)do
			@grilleTest.clearAretes
			@grilleTest.clearSommets
			@listeInter = []
			afficheEcran
    end
		ajouterImage(@boutonRecom,"#{$cheminRacineHashi}/Interface/img/restart_icon.png")
  end

  def initChrono
		@boxChrono = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
		@boutonSablier = UnBoutonPerso.new("test","Chrono")
		@boutonSablier.verrouiller()

		if(@classe)
			@chr = Chrono.nouveau()
			@boutonSablier.show
			@boxChrono.show
			@chr.set_name("LabelChrono")
			@chr.show
			ajouterContenu(@boxChrono,@boutonSablier)
			ajouterContenu(@boxChrono,@chr)

			@chr.chronometrer()

		end
		ajouterImage(@boutonSablier,"#{$cheminRacineHashi}/Interface/img/hourglass_icon.png")

  end

  def initBoxJeu
    @boxJeu = UnBoutonPerso.new("ceci est ma grille de Jeu")do
      @boxJeu.set_sensitive(false)
    end
  end

	def masquerBouton
		@boutonAnnulHypo.hide
		@boutonValidHypo.hide
		if @tuto == nil
			@labelMessage.hide
		end
		if @aideTxt != nil
			@aideTxt.hide
		end
		if @labelMessage != nil
			@labelMessage.hide
		end
		@boutonErreur.hide
		@boutonAideTxt.hide
		@boutonAideVisu.hide
	end

	def initTailleCase
		@tailleCase = (@tailleArea - 50) / (@longueur > @largeur ? @longueur : @largeur)
		@fontSize = @tailleCase / 2
		@tailleCercle = @tailleCase / 5 * 2
		@largeurSurbri = @tailleCase / 4
	end

	def masquerAllBouton
		@boutonHypo.hide
		@boutonAide.hide
		@boutonAnnul.hide
		@boutonRecom.hide
	end

	def initBoutonTuto(numNiveau)
		case(numNiveau)
		when "D1"
		when "D2"
			@boutonAnnul.show
		when "D3"
			@boutonAnnul.show
			@boutonAide.show
			@boutonRecom.show
		else
			@boutonAnnul.show
			@boutonAide.show
			@boutonRecom.show
			@boutonHypo.show
		end
	end

	def conditionGagnante()
		if(grilleGagnante && !@hypothese && @tuto == nil)
			if(@chr != nil)
				@chr.arreter()
				@chr.fin()
				@@fenetre.changerWidget(FenetreVictoire.new(@@fenetre,@difficulte,@chr))
			else
				@@fenetre.changerWidget(FenetreVictoire.new(@@fenetre,@difficulte,nil))
			end
		end
	end

	def ajouteMalus(penalite)
		if(@chr != nil)
			@chr.addMalus(penalite)
		end
	end
end
