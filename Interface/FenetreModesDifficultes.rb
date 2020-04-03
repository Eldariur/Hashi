
require_relative 'FenetreModeChrono.rb'

class FenetreModesDifficultes < FenetreModeChrono

  def initialize(window)
    @@fenetre = window
    super(@@fenetre)

    bouton4 = UnBoutonPerso.new("Personnalisé")

    bouton4.signal_connect('clicked') {
      @@fenetre.changerWidget(FenetreParametres.new(@@fenetre))
    }

    self.add(bouton4)

    self.show_all

  end

end
