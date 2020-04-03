require_relative "./Score.rb"
require_relative "./Highscore.rb"

# Cette classe represente un classement.
class Classement
  attr:liste, true

   # Creer un nouveau classement.
	 def Classement.creer()
		 new()
	 end

   # Privatise le new.
   private_class_method :new

   # Initialisation de la class Classement.
   def initialize()
     @liste = Array.new
     self.recupererDonnees()
   end

  # Cette methode verifie si un nouveau socre doit être enregistrer.
  # === Parametre
  # * +score+ : score Le score à vérifier.
  # === Return
  # * +boolean+ : boolean Un boolean qui indique si un score doit être enregistrer.
  def isHighScore(score)
    self.recupererDonnees()
    if(@liste.empty? || @liste.count < 20 || @liste.last.score.to_i < score.to_i ) then
      if(@liste.count >= 20) then
        puts "    Sortie de -> #{@liste.last}"
        @liste.last.destroy
      end
      return true
    end
    return false
  end

  # Cette methode met à jour le classement avec la base de données.
  def recupererDonnees()
    @liste = Highscore.order(:score).take(20).reverse
  end

	# Cette methode redefini to_s pour afficher un classement.
  def to_s
    self.recupererDonnees()
    res = ""
    @liste.each do |e|
      res = res.to_s + "Highscore -> Pseudo : #{e.name}, points : #{e.score}, id : #{e.id}\n"
    end
    return res
  end

end
