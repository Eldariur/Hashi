require_relative "../Classement/Score.rb"
require_relative "../Classement/Highscore.rb"

# Cette classe représente un classement.
class Classement
  #@liste -> La liste de highscore.
  #@difficulte -> La difficulté associée au classement.

	# Accesseur get sur l'attribut liste.
	attr:liste, false
	# Accesseur get sur l'attribut difficulte.
	attr:difficulte, false

	# Privatise le new.
	private_class_method :new

	# Initialisation de la classe Classement.
	def initialize(difficulty)
		@liste = Array.new
		@difficulte = difficulty
		self.recupererDonnees()
	end

  # Créer un nouveau Classement.
	def Classement.creer(difficulty)
		new(difficulty)
	end

	# Cette méthode vérifie si un nouveau score doit être enregistré.
  # === Paramètres
  # * +score+ : score Le score à vérifier.
  # === Return
  # * +boolean+ : boolean Un boolean qui indique si un score doit être enregistré.
  def isHighScore?(score)
    self.recupererDonnees()
    if(score.difficulte == @difficulte) then
      if(@liste.empty? || @liste.count < 20 || @liste.last.score.to_i < score.to_i ) then
        if(@liste.count >= 20) then
          puts "    Sortie de -> #{@liste.last}"
          @liste.last.destroy
        end
        return true
      end
    end
    return false
  end

  # Cette méthode met à jour le classement avec la base de données.
  def recupererDonnees()
    @liste = Highscore.where(:difficulty => @difficulte).order(:score).take(20).reverse
  end

	# Cette méthode redéfinit to_s pour afficher un classement.
	#
	# === Return
	#
	# Une chaîne de caractère contenant des infos sur le classement
	@Override
  def to_s
    self.recupererDonnees()
    res = ""
    @liste.each do |e|
      res = res.to_s + "Highscore -> Pseudo : #{e.name}, points : #{e.score}, id : #{e.id}, difficulte : #{e.difficulty}\n"
    end
    return res
  end

end
