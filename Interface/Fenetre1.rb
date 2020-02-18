require 'gtk3'
require_relative '../Code/Grille.rb'
require_relative '../Code/Case.rb'
require_relative '../Code/Sommet.rb'
require_relative '../Code/Arete.rb'
require_relative 'UnBoutonPerso.rb'
require_relative 'UnLabelPerso.rb'
require_relative 'UneCasePerso.rb'




class Fenetre < Gtk::Window

	attr_reader :grilleTest
	def initialize

		#

		super()
		self.name="mainWindow2"
		self.set_default_size(600,600)
		vbox = Gtk::Box.new(:VERTICAL)
		self.window_position=Gtk::WindowPosition::CENTER
		css=Gtk::CssProvider.new
		css.load(path: "./css/style.css")
		Gtk::StyleContext::add_provider_for_screen(Gdk::Screen.default,css,Gtk::StyleProvider::PRIORITY_APPLICATION)

		#self.updateData
		self.signal_connect('configure-event') {
			#self.updateData
			false # exécute le handler par défaut
		}

		self.signal_connect('destroy') {
		   Gtk.main_quit
		}


		x = 5
		y = 5
		tbl = Gtk::Table.new(x,y,FALSE)

		#####################################
		@grilleTest = Grille.creer(5, 5)
		sommet11 = Sommet.creer(4, @grilleTest.getCase(0, 0))
		sommet12 = Sommet.creer(2, @grilleTest.getCase(2, 0))
		sommet13 = Sommet.creer(2, @grilleTest.getCase(0, 3))
		arete11 = Arete.creer(sommet11, sommet13)
		@grilleTest.addSommet(sommet11)
		@grilleTest.addSommet(sommet12)
		@grilleTest.addSommet(sommet13)
		@grilleTest.addArete(arete11)
		#####################################

		# ========================= Partie avec des boutons =================
		# 0.upto(x) do |i|
		# 	0.upto(y) do |j|
		# 		if( i == 0 || j == 0 || i == x || j == y)
		# 	  	tbl.attach(UnBoutonPerso.new(nil,"UneCasePerso"),i,i+1,j,j+1)
		# 			#gridJeu.get_child_at(y+1,x+1).image=(dimImage("img/pont_rouge_jap.jpg"))
		# 		end
		# 		# if(grille1.getCase(i,j) != nil )
		# 		# 	tbl.attach(UnBoutonPerso.new("1"),i,i+1,j,j+1)
		# 		# end
		#
		#   end
	  # end
		#
		# grille1.sommets.each do |s|
		# 	i = s.position.x
		# 	j = s.position.y
		# 	puts "sommet trouvé : x = "+i.to_s+" y = "+j.to_s
		# 	tbl.attach(UnBoutonPerso.new("1"),i,i+1,j,j+1)
		# end
		#
		# cptX=0
		# cptY=0
		# depX=nil
		# depY=nil
		# arrX=nil
		# arrY=nil
		# gridJeu = Gtk::Grid.new()
		#
		# grille1.aretes.each do |a|
		#
		#
		# 	puts "aretes trouvée "
		# 	a.getListeCase().each{ |c|
		# 		puts "arete dans cette case x = "+c.x.to_s+" y = "+c.y.to_s
		# 		if(depX == nil && depY == nil)
		# 			depX = c.x
		# 			depY = c.y
		# 		else
		# 			if(depX < c.x)
		# 				cptX+=1 end
		# 			if(depX > c.x)
		# 				cptX-=1 end
		# 			if(depY < c.y)
		# 				cptY+=1 end
		# 			if(depY > c.y)
		# 				cptY-=1 end
		# 		end
		# 	}
		# 	arrX = depX+cptX
		# 	arrY = depY+cptY
		# 	puts "l'arete va de la case x = "+depX.to_s+" y = "+depY.to_s+" à la case x = "+arrX.to_s+" y = "+arrY.to_s
		#
		# end
		#
		# btnArete = UnBoutonPerso.new("|","UneCasePerso")
		# tbl.attach(btnArete,depX,arrX+1,depY,arrY+1,Gtk::AttachOptions::EXPAND,nil)
		#
		# long = 5
		# larg = 5
		# grilleTest=Array.new(long) { Array.new(larg) {0} }
		#
		# grilleTest[0][2] = UnBoutonPerso.new("test")
		# grilleTest[0][2].signal_connect('clicked'){
		# 	puts 'clic'
		# }



	  # c1.signal_connect('clicked'){
	  #   puts "pressed c1"
		# 	btnArete = UnBoutonPerso.new("4","UneCasePerso")
		# 	tbl.attach(btnArete,1,2,2,4,Gtk::AttachOptions::EXPAND,nil)
		#
		# 	self.show_all
	  # }
		#
	  # tbl.attach(c1,1,2,1,2)
		# tbl.attach(c2,4,5,2,3)
		# tbl.attach(c3,1,2,4,5)
		# tbl.attach(c4,5,6,4,5)

			# ========================= Partie avec des coordonnées =================


			#tbl.attach(UneCasePerso.new("test"),1,2,1,2)

	    #img = Gtk::Image.new("img/jeuDeTest.png")
			# area = Gtk::DrawingArea.new()
			# area.draw_point(gc, x, y)


			@darea = Gtk::DrawingArea.new


			@darea.signal_connect "draw" do
					on_draw
			end
			# on_draw
			x=10
			y=10


			hpaned = Gtk::HPaned.new

			# hpaned = Gtk::Paned.new(:Horizontal)
			# hpaned.signal_connect("button-release-event") do
			# 	x+=10
			# 	y+=10
			# 	puts "dessine une ligne"
			# 	@cr = @darea.window.create_cairo_context
			#
			# 	draw_maLigne(@cr,x,y,150,60)
			# end

			vbox.add(tbl)
			hpaned.add(@darea)

			self.signal_connect("button-press-event") { |widget, event| mouseClick(event) }
	    #self.add(vbox)
			self.add(hpaned)

	    #self.add(img)


		#self.add(HudAccueil.new(self))
		self.show_all
		Gtk.main

	end

	def mouseClick(event)
	        puts(event.x, event.y).to_s+"=="
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
			puts "====="
			i = 0
			j = 0
			taillePix = 25
			padding = 20
		@grilleTest.sommets.each{ |s|
			x = s.position.x
			y = s.position.y
			puts "il y a un sommet à la case x = "+x.to_s+" y = "+y.to_s+" i = "+i.to_s+" j = "+j.to_s
			cr.rectangle(i*x,j*y,i*x+taillePix,j*y+taillePix)
			cr.fill

			i+=1
			j+=1

		}
	end

	def draw_maLigne(cr,x1,y1,x2,y2)
		cr.move_to x1, y1
		cr.line_to x2,y2
		cr.stroke_preserve

	end

end

 f = Fenetre.new()
