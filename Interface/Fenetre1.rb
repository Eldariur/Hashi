require 'gtk3'
require_relative 'UnBoutonPerso.rb'
require_relative 'UnLabelPerso.rb'
require_relative 'UneCasePerso.rb'
require_relative '../Code/Grille.rb'
require_relative '../Code/Case.rb'
require_relative '../Code/Sommet.rb'
require_relative '../Code/Arete.rb'




class Fenetre < Gtk::Window

	# Return une instance de Fenetre 480*270 centrée, exécutant Fenetre#update
	# au déplacement/redimensionnement
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
		@nbLigne=6
		@nbColonne=6

		grille = Grille.new(@nbLigne,@nbColonne)

		s1 = Sommet.new(5,Case.new(1,5,grille))
		s2 = Sommet.new(5,Case.new(1,5,grille))
		s1.rechercheVoisin()
		#s1 = SommetTempo.new("s1",1,5)


		# tbl = Gtk::Table.new(x,y,FALSE)
		# 	c1 = UnBoutonPerso.new("1","UnBoutonPerso")
		# 	c2 = UnBoutonPerso.new("2")
		# 	c3 = UnBoutonPerso.new("3")
		# 	c4 = UnBoutonPerso.new("4")
		#
		# @click=false
		#
	  # c1.signal_connect('clicked'){
	  #   puts "pressed c1"
		# 	btnArete = UnBoutonPerso.new("4","UneCasePerso")
		#
		# 	if(@click == false)
		# 		puts "créer arete"
		# 		tbl.attach(btnArete,1,2,2,4,Gtk::AttachOptions::EXPAND,nil)
		# 		@click = true
		# 	end
		#
		#
		#
		#
		#
		# 	self.show_all
	  # }
		#
	  # tbl.attach(c1,1,2,1,2)
		# tbl.attach(c2,4,5,2,3)
		# tbl.attach(c3,1,2,4,5)
		# tbl.attach(c4,5,6,4,5)
		#
		# 0.upto(x) do |i|
		# 	0.upto(y) do |j|
		# 		if( i == 0 || j == 0)
		# 	  	tbl.attach(UnBoutonPerso.new(nil,"UneCasePerso"),i,i+1,j,j+1)
		# 		end
		#   end
	  # end

			#tbl.attach(UneCasePerso.new("test"),1,2,1,2)

	    #img = Gtk::Image.new("img/jeuDeTest.png")
			# area = Gtk::DrawingArea.new()
			# area.draw_point(gc, x, y)



			#vbox.add(tbl)
			# hpaned.add(@darea)

	    self.add(vbox)

	    #self.add(img)


		#self.add(HudAccueil.new(self))
		self.show_all
		Gtk.main

	end

	attr_accessor :nbLigne, :nbColonne, :grille # => A retirer plus tard ========================================================


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
	#
	# 		add @darea
	# end

	def on_draw

			cr = @darea.window.create_cairo_context
			@cr = cr

			#draw_colors cr
			draw_maLigne(@cr,50,50,150,60)
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

	def draw_maLigne(cr,x1,y1,x2,y2)
		cr.move_to x1, y1
		cr.line_to x2,y2
		cr.stroke_preserve

	end

end

class SommetTempo
    #@listArete
    attr_accessor :position
    def initialize(valeur, x, y)
        @valeur = valeur
        #@position = position #la case dans lequel est le sommet
				@x=x
				@y=y
        @listArete = Array.new()
        #@position.ajouterContenu(self)
    end

		def rechercheVoisin()
			@x.upto(@nbLigne) do |i|
				#if(grille[i][@nbColonne] == )
			end
		end
end

 f = Fenetre.new()
