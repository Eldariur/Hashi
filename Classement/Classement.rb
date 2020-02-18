load ("Score.rb")

class Classement

  attr:liste, true

  def isHighScore(score)
    if(@liste.empty? || @liste.last.score < score) then return true end
    return false
  end

  def ajouter(score)
    @liste.push(score)
  end

  def retirerDernier()
    @liste.pop()
  end

end
