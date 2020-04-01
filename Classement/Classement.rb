load ("Score.rb")

class Classement

  attr:liste, true

  # Creer un nouveau score.
	 def Classement.creer()
		 new()
	 end

   def initialize()
     @liste = Array.new
   end

   #Privatise le new.
   private_class_method :new

  def isHighScore(score)
    if(@liste.empty? || @liste.last.score < score || @liste.count < 20) then return true end
    return false
  end

  def ajouter(score)
    @liste.push(score)
  end

  def retirerDernier()
    @liste.pop()
  end

  def recupererDonnees()
    @liste = Score.take(20)
  end

  def to_s
    return @liste.to_s
  end

end
