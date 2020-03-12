require 'gtk3'
require_relative 'Grille.rb'
require_relative 'Case.rb'
require_relative 'Sommet.rb'
require_relative 'Arete.rb'
require_relative 'Aide.rb'
require_relative '../Interface/UnBoutonPerso.rb'
require_relative '../Interface/UnLabelPerso.rb'
require_relative '../Interface/UneCasePerso.rb'
require_relative 'Generateur.rb'



class Fenetre < Gtk::Window

	attr_reader :grilleTest, :longueur, :largeur
	def initialize()


		super()
		self.name="mainWindow2"
		self.set_default_size(900,600)
		vbox = Gtk::Box.new(:VERTICAL)
		self.window_position=Gtk::WindowPosition::CENTER
		css=Gtk::CssProvider.new
		css.load(path: "../Interface/css/style.css")
		Gtk::StyleContext::add_provider_for_screen(Gdk::Screen.default,css,Gtk::StyleProvider::PRIORITY_APPLICATION)

		#self.updateData
		self.signal_connect('configure-event') {
			#self.updateData
			false # exécute le handler par défaut
		}

		self.signal_connect('destroy') {
		   Gtk.main_quit
		}

		@listeInter = []
		x = 10
		y = 10
		tbl = Gtk::Table.new(x,y,FALSE)

		# #####################################
		# @grilleTest = Grille.creer(5, 5)
		# sommet11 = Sommet.creer(4, @grilleTest.getCase(0, 0))
		# sommet12 = Sommet.creer(2, @grilleTest.getCase(2, 0))
		# sommet13 = Sommet.creer(2, @grilleTest.getCase(0, 3))
		# arete11 = Arete.creer(sommet11, sommet13)
		# arete12 = Arete.creer(sommet11, sommet12,true)
		#arete11 = Arete.creer(sommet11, sommet13)
		# @grilleTest.addSommet(sommet11)
		# @grilleTest.addSommet(sommet12)
		# @grilleTest.addSommet(sommet13)
		# @grilleTest.addArete(arete11)
		# #####################################

		# #####################################
		# @grilleTest = Grille.creer(5, 5)
		# sommet11 = Sommet.creer(2, @grilleTest.getCase(2, 0))
		# sommet12 = Sommet.creer(2, @grilleTest.getCase(0, 2))
		# sommet13 = Sommet.creer(8, @grilleTest.getCase(2, 2))
		# sommet14 = Sommet.creer(2, @grilleTest.getCase(4, 2))
		# sommet15= Sommet.creer(2, @grilleTest.getCase(2, 4))
		# arete11 = Arete.creer(sommet11, sommet13)
		# arete12 = Arete.creer(sommet13, sommet14,true)
		# #####################################

		#####################################
		gene = Generateur.new(nil,10, 10, 10)
		@grilleTest = gene.creeUneGrille()
		# sommet11 = Sommet.creer(1, @grilleTest.getCase(0, 0))
		# sommet12 = Sommet.creer(2, @grilleTest.getCase(2, 0))
		# sommet13 = Sommet.creer(3, @grilleTest.getCase(4, 0))
		# sommet14 = Sommet.creer(4, @grilleTest.getCase(0, 2))
		# sommet15= Sommet.creer(5, @grilleTest.getCase(4, 2))
		# sommet16= Sommet.creer(6, @grilleTest.getCase(2, 4))
		# arete11 = Arete.creer(sommet11, sommet12)
		# arete12 = Arete.creer(sommet12, sommet13)
		#####################################

		@longueur = @grilleTest.longueur
		@largeur = @grilleTest.largeur

			@darea = Gtk::DrawingArea.new

			@nbClick = 0


			@darea.signal_connect "draw" do
					on_draw
					#tracerGrille(@grilleTest)  #<================AIDE VISUEL TEMPO
			end

			# on_draw
			x=10
			y=10

			@@x1=0
			@@y1=0
			@@x2=0
			@@y2=0


			hpaned = Gtk::HPaned.new
			hpaned2 = Gtk::HPaned.new


			# hpaned = Gtk::Paned.new(:Horizontal)
			# hpaned.signal_connect("button-release-event") do
			# 	x+=10
			# 	y+=10
			# 	puts "dessine une ligne"
			# 	@cr = @darea.window.create_cairo_context
			#
			# 	draw_maLigne(@cr,x,y,150,60)
			# end

			button = Gtk::Button.new('Demander aide')
			button.signal_connect('clicked') {
				aide = Aide.creer(@grilleTest)
				#aide.afficherId()
				puts aide.getMessageAide()
			}

			hpaned.add(@darea)

			tbl.attach(hpaned, 0, 9, 1, 10)
			tbl.attach(button, 9, 10, 0, 1)

			add(tbl)

			self.signal_connect("button-press-event") { |widget, event| mouseClick(event) }
			self.add(hpaned)

	    #self.add(img)

		#self.add(HudAccueil.new(self))
		self.show_all
		Gtk.main

	end

	def mouseClick(event)
		# copie tracerGrille
		tailleCase = 50
		nbCase = @largeur
		paddingX = 50
		paddingY = 25
		@nbClick += 1
		cr = @darea.window.create_cairo_context
	  #       puts(event.x, event.y).to_s+"=="
		# 			if(@nbClick == 0)
		# 				puts "test"
		# 				@@x1 = event.x
		# 				@@y1 = event.y
		# 				@nbClick += 1
		# 			else
		# 				puts @@x1
		# 				@@x2 = event.x
		# 				@@y2 = event.y
		# 				puts "trace une ligne entre deux points x="+@@x1.to_s+" y="+@@y1.to_s+" x2="+@@x2.to_s+"y2="+@@y2.to_s
		# 				cr.set_source_rgb 0.2, 0.23, 0.9
		# 				draw_maLigne(cr,@@x1,@@y1,@@x2,@@y2)
		# 				@@x1 = @@x2
		# 				@@y1 = @@y2
		# 			end
		# 			self.show_all
		x = event.x
		y = event.y

		if(x > paddingX && x < paddingX+tailleCase*nbCase && y > paddingY && y < paddingY+tailleCase*nbCase) #si dans la grille
			caseX = (x - paddingX).to_i/tailleCase
			caseY = (y -paddingY).to_i/tailleCase

			caseTest = @grilleTest.getCase(caseX,caseY)


			# sensé regarder le contenu de la case mais PROBLEME car toutes les cases sont des sommets !
			caseTest = @grilleTest.getCase(caseX,caseY)
			caseSom = nil
			if(estSommet?(caseTest))
				afficheSurbri
				videSurbri
				@caseSom = @grilleTest.getCase(caseX,caseY)

				listV = rechercherVoisins(caseTest)
				listV.each { |v|

					@listeInter += getlisteInterCase(caseTest,v)
					@listeInter.push("|")
				}
				afficheSurbri()

				@listeInter.each { |c|
					if(c != "|" && c.class != Sommet) #<==== FAUX
						c.setSurbri(true)
					end
				}
			end

			if(caseTest.surbrillance && caseTest.class != Sommet) # si la case est en surbrillance
				if(caseTest.contenu.class == Arete)
					s1 = caseTest.contenu.getSommet1
					s2 = caseTest.contenu.getSommet2

					if(event.button == 1)
						#creation arete
						if(!caseTest.contenu.estDouble)
							caseTest.contenu.setDouble(true)
						end
					# testAffichageGrille

					elsif (event.button == 3)
						if(caseTest.contenu.estDouble)
							caseTest.contenu.setDouble(false)
							caseTest.contenu.getSommet1.setComplet(false)
							caseTest.contenu.getSommet2.setComplet(false)

						else
							caseTest.contenu.supprimer
						end
					else
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
								if(s1 != nil && s2 != nil)
								end





							end
						end
						caseTest = @grilleTest.getCase(caseX,caseY)

						if(s1 != nil && caseTest.contenu.class != Sommet)
							if(s1.contenu.valeur > s1.contenu.compterArete && s2.contenu.valeur > s2.contenu.compterArete)#le sommet est complet
								newA = Arete.creer(s1.contenu,s2.contenu) #<================ a voir
							elsif(s1.contenu.valeur == s1.contenu.compterArete)
								s1.contenu.setComplet(true)
							elsif(s2.contenu.valeur == s2.contenu.compterArete)
								s2.contenu.setComplet(true)
							end

						end
					end
				end
			else

				videSurbri

			end
			drawSurbri(cr)
			afficheEcran(cr)
		end
	end

	attr_accessor :nbClick, :listeInter, :caseSom

	def drawSurbri(cr)
		# exemple 5 5
		tailleCase = 50
		nbCase = @largeur
		paddingX = 50
		paddingY = 25

		x1 = nil
		x2 = nil
		y1 = nil
		y2 = nil

		cr.set_source_rgb 0.9, 1, 0

		@listeInter.each { |c|
			if(c == "|")

				if(x1 < x2 || caseSom.x < x1)
					cr.rectangle x1*tailleCase+paddingX-3+tailleCase, y1*tailleCase+paddingY+13, (x2-x1)*tailleCase-tailleCase+8, (y2-y1)*tailleCase+22
				elsif(x1 > x2 || caseSom.x > x1)
					cr.rectangle x1*tailleCase+paddingX+5, y1*tailleCase+paddingY+13, (x2-x1)*tailleCase-8+tailleCase, (y2-y1)*tailleCase+22
				elsif(y1 < y2 || caseSom.y < y1)
					cr.rectangle x1*tailleCase+paddingX+15, y1*tailleCase+paddingY-5+tailleCase, (x2-x1)*tailleCase+22, (y2-y1)*tailleCase-tailleCase+8
				else
					cr.rectangle x1*tailleCase+paddingX+15, y1*tailleCase+paddingY+5, (x2-x1)*tailleCase+22, (y2-y1)*tailleCase-8+tailleCase
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
		cr.fill
		cr.set_source_rgb 0,0,0

	end

	def afficheSurbri()
		@listeInter.each do |c|
			if(c != "|")
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
		tailleCase = 50
		nbCase = @largeur
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
		(c.x+1).upto nbCase-1 do |i|
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
		(c.y+1).upto nbCase-1 do |i|
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
		testAffichageCoord(s1)
		testAffichageCoord(s2)
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
		afficheSurbri
		@listeInter.each {|c|
			if(c.class == Case)
				c.setSurbri(false)
			end
			#@listeInter.delete_at(@listeInter.index(c))
		}
		@listeInter = []
	end


	def estSommet?(c)
		@grilleTest.sommets.each do |s|
			if(s.position.x == c.x && s.position.y == c.y)
				return true
			end
		end
		return false
	end

	def tracerGrille(grille)
		# exemple 5 5
		tailleCase = 50
		nbCase = @largeur
		paddingX = 50
		paddingY = 25
		cr = @darea.window.create_cairo_context



		0.upto nbCase do |i|
			draw_maLigne(cr,i*tailleCase+paddingX,paddingY,i*tailleCase+paddingX,nbCase*tailleCase+paddingY)
		end
		0.upto nbCase do |i|
			draw_maLigne(cr,paddingX,i*tailleCase+paddingY,nbCase*tailleCase+paddingX,i*tailleCase+paddingY)
		end


	end

	def changerWidget(nouveau)
		self.remove(self.child).add(nouveau)
		self.show_all
		self
	end


	def dimImage(str)
		image = Gtk::Image.new(str)
		image.pixbuf = image.pixbuf.scale(28,28) if image.pixbuf!=nil
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

			cr = @darea.window.create_cairo_context
			@cr = cr

			#draw_colors cr
			# draw_maLigne(@cr,50,50,150,60)
			drawSommets(cr)
			drawAretes(cr)
			#cairo_line_to(cr, 10, 15)

	end
	attr_accessor :cr

	def draw_colors cr

			cr.set_source_rgb 0.2, 0.23, 0.9
			cr.move_to 10, 10
			cr.line_to 150, 15
			cr.move_to 150, 30
			cr.stroke

			cr.set_source_rgb 0.9, 0.1, 0.1
			cr.rectangle 130, 15, 90, 60
			cr.fill

			cr.set_source_rgb 0.4, 0.9, 0.4
			cr.rectangle 250, 15, 90, 60
			cr.fill
	end

	def drawSommets(cr)
		# copie de tracerGrille
		tailleCase = 50
		nbCase = @largeur
		paddingX = 50+17
		paddingY = 25+35

			cr.set_font_size(25)
			cr.set_source_rgb 0,0,0

			i = 0
			j = 0
			taillePix = 25
			padding = 20
		@grilleTest.sommets.each{ |s|
			x = s.position.x
			y = s.position.y
			if(s.complet)
				draw_maLigne(cr,x*tailleCase+paddingX ,y*tailleCase+paddingY,x*tailleCase+paddingX+15 ,y*tailleCase+paddingY-25)
			end
			cr.move_to x*tailleCase+paddingX+30 ,y*tailleCase+paddingY-10
			cr.arc x*tailleCase+paddingX+9,y*tailleCase+paddingY-10,20,0,2*Math::PI

			cr.move_to x*tailleCase+paddingX ,y*tailleCase+paddingY
			cr.show_text(s.valeur.to_s)



			i+=1
			j+=1

		}
	end

	def drawAretes(cr)
		# copie de tracerGrille
		tailleCase = 50
		nbCase = @largeur
		paddingX = 50+15
		paddingY = 25+35
		verti = false
		hori = false
		varX = 0
		varY = 0
		minX = 0
		minY = 0

		cr.set_source_rgb 0,0,0

			i = 0
			j = 0
			taillePix = 25
			padding = 20
		@grilleTest.aretes.each{ |a|
			x1 = a.getSommet1.position.x
			y1 = a.getSommet1.position.y
			x2 = a.getSommet2.position.x
			y2 = a.getSommet2.position.y
			if(x1 == x2)
				hori = false
				verti = true
			else
				verti = false
				hori = true
			end
			#puts "tracer l'arete entre x1 = "+x1.to_s+" y1 = "+y1.to_s+" x2 = "+x2.to_s+" y2 = "+y2.to_s+" vertical = "+verti.to_s
			if(verti==true)
				varX = 0
				varY = 15
				minX = 0
				minY = tailleCase
				paddingX += 10
				paddingY = 25+35

			else
				varX = 35
				varY = 0
				minX = tailleCase
				minY = 0
				paddingY -= 10
				paddingX = 50+15
			end

			if(!a.estDouble)# || 1)
				cr.move_to x1*tailleCase+paddingX+varX, y1*tailleCase+paddingY+varY
				cr.line_to x2*tailleCase+paddingX+varX-minX, y2*tailleCase+paddingY+varY-minY
				cr.stroke_preserve
			else
					case verti
					when true
						cr.move_to x1*tailleCase+paddingX-5+varX, y1*tailleCase+paddingY+varY
						cr.line_to x2*tailleCase+paddingX-5+varX-minX, y2*tailleCase+paddingY+varY-minY
						cr.stroke_preserve
						cr.move_to x1*tailleCase+paddingX+5+varX, y1*tailleCase+paddingY+varY
						cr.line_to x2*tailleCase+paddingX+5+varX-minX, y2*tailleCase+paddingY+varY-minY
						cr.stroke_preserve

					when false
						cr.move_to x1*tailleCase+paddingX+varX, y1*tailleCase+paddingY-5+varY
						cr.line_to x2*tailleCase+paddingX+varX-minX, y2*tailleCase+paddingY-5+varY-minY
						cr.stroke_preserve
						cr.move_to x1*tailleCase+paddingX+varX, y1*tailleCase+paddingY+5+varY
						cr.line_to x2*tailleCase+paddingX+varX-minX, y2*tailleCase+paddingY+5+varY-minY
						cr.stroke_preserve
					end


			end




			i+=1
			j+=1

		}
	end

	def draw_maLigne(cr,x1,y1,x2,y2)
		cr.move_to x1, y1
		cr.line_to x2,y2
		cr.stroke_preserve

	end

	def testAffichageGrille

	end

	def testAffichageCoord(c)

	end

	def clearEcran(cr)
		cr.set_source_rgb 0.96, 0.96, 0.96
		cr.rectangle 0, 0, 700, 700
		cr.fill
		cr.set_source_rgb 0, 0, 0
	end

	def afficheEcran(cr)
		clearEcran(cr)
		drawSurbri(cr)
		drawSommets(cr)
		drawAretes(cr)
	end

end

 f = Fenetre.new()
