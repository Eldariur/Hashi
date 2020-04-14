require 'gtk3'

require_relative './src/Interface/FenetreMenu.rb'
require_relative './src/Interface/FenetreMenuJouer.rb'
require_relative './src/Interface/FenetreParametres.rb'
require_relative './src/Interface/FenetreRegle.rb'
require_relative './src/Interface/FenetreModesDifficultes.rb'
require_relative './src/Interface/UnLabelPerso.rb'
require_relative './src/Interface/UnBoutonPerso.rb'
require_relative './src/Interface/FenetreModeChrono.rb'
require_relative './src/Interface/FenetreVictoire.rb'
require_relative './src/Interface/FenetreClassement.rb'
require_relative './src/Interface/FenetreTuto.rb'
require_relative './src/Interface/FenetreJeu.rb'
require_relative './src/Interface/FenetreJeuTuto.rb'
require_relative './src/Tutoriel/Tutoriel.rb'
require_relative './src/Interface/BoutonTuto.rb'


# Classe principale du programme
class Main < Gtk::Window
    $cheminRacineHashi = __dir__

    ## Partie initialize

    # Initialisation de la classe principale
    def initialize
        super()
        self.name="WindowPrincipale"
        self.move(0,0)

        self.fullscreen()

        self.set_default_size(Gdk::Screen::width < 3000 ? Gdk::Screen::width : Gdk::Screen::width/2,Gdk::Screen::height)
        self.set_resizable(false)
        self.set_title("Jeu Hashi")
        self.window_position=Gtk::WindowPosition::CENTER

        css=Gtk::CssProvider.new
        css.load(path: "#{$cheminRacineHashi}/src/Interface/css/style.css")
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

    ## Méthode permettant de changer de fenêtre
    #
    # === Paramètres
    #
    # * +nouveau+ : La nouvelle fenêtre à afficher
    def changerWidget(nouveau)
        self.remove(self.child).add(nouveau)
        self.show_all
        self
    end


end

puts $cheminRacineHashi
Main.new
