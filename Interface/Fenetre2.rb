require 'gtk3'

require_relative 'FenetreMenu.rb'
require_relative 'FenetreMenuJouer.rb'
require_relative 'FenetreParametres.rb'
require_relative 'FenetreModesDifficultes.rb'
require_relative 'UnLabelPerso.rb'
require_relative 'UnBoutonPerso.rb'
require_relative 'FenetreModeChrono.rb'
#require_relative 'FenetreVictoire.rb'
#require_relative 'FenetreClassement.rb'
require_relative 'FenetreTuto.rb'
require_relative 'FenetreJeu.rb'
require_relative 'FenetreJeuTuto.rb'
require_relative 'FenetreTest.rb'
require_relative '../Tutoriel/Tutoriel.rb'

require_relative 'BoutonTuto.rb'

# require_relative 'Fenetre1.rb'



class FenEx < Gtk::Window

  def initialize
    super()
		self.name="WindowPrincipale"
    self.move((0)/2,0)

		self.fullscreen()

		self.set_default_size(Gdk::Screen::width,Gdk::Screen::height)
    self.set_resizable(false)
    self.set_title("Jeu Hashi")
		self.window_position=Gtk::WindowPosition::CENTER

    css=Gtk::CssProvider.new
    css.load(path: "./css/style.css")
    #inversez les commentaires pour
    #css.load(path: "/home/hashiwokakero/Hashi/Interface/css/style.css")
    Gtk::StyleContext::add_provider_for_screen(Gdk::Screen.default,css,
                                    Gtk::StyleProvider::PRIORITY_APPLICATION)

    self.signal_connect('destroy') {
       Gtk.main_quit
    }

    self.add(FenetreMenu.new(self))


    self.show_all
    Gtk.main
  end

  def changerWidget(nouveau)
		self.remove(self.child).add(nouveau)
		self.show_all
		self
	end


end



fenex = FenEx.new
