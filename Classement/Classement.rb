load ("Score.rb")
#load ("Highscore.rb")

class Classement
  attr:liste, false

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
    Highscore.order(:score)
    @liste = Highscore.take(20)
    @liste = @liste.sort{ |a,b| a.score.to_i <=> b.score.to_i }.reverse
  end

  def to_s
    res = ""
    @liste.each do |e|
      res = res.to_s + "Highscore -> Pseudo : #{e.name}, points : #{e.score}, id : #{e.id}\n"
    end
    return res
  end

end
