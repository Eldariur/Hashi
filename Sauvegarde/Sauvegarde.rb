require 'yaml'

# Cette classe represente un sauvegarde.
class Sauvegarde
  #@grille -> La grille sauvegardé.
  #@chronometre -> Le chronometre sauvegardé.
  #@estHypothese -> Si la sauvegarde est une hypothese ou non.

  # Privatise le new.
  private_class_method :new

  # Initialisation de la class Sauvegarde.
  # === Parametre
  # * +grille+ : grille La grille a sauvegarder.
  # * +chrono+ : chrono Le chronometre a sauvegarder.
  # * +hypothese+ : hypothese Le choix d'une sauvegarde pour une hypothese ou non.
  def initialize(grille, chrono, hypothese = false)
    @grille = grille
    @estHypothese = hypothese
    if(!@estHypothese) then @chronometre = chronometre
    else @chronometre = nil end
  end

  # Creer un nouveau chronomètre.
  # === Parametre
  # * +grille+ : grille La grille a sauvegarder.
  # * +chrono+ : chrono Le chronometre a sauvegarder.
  # * +hypothese+ : hypothese Le choix d'une sauvegarde pour une hypothese ou non.
  def Sauvegarde.nouvelle(grille, chrono, hypothese = false)
    new(grille, chrono, hypothese)
  end

  # Accesseur get sur l'attribut grille.
  attr:grille, false
  # Accesseur get et set sur l'attribut chronometre.
  attr:chronometre, true
  # Accesseur get sur l'attribut estHypothese.
  attr:estHypothese, false

  # Renvoie la grille de la sauvegarde.
  # === Return
  # * +@grille+ : @grille La grille de la sauvegarde.
  def getGrille()
    return @grille
  end

  # Renvoie le chronometre de la sauvegarde.
  # === Return
  # * +@chronometre+ : @chronometr Le chronometre de la sauvegarde.
  def getChrono()
    return @chronometre
  end

  def getSaveName()
    res = Time.now().to_s.split(' ')
    res.pop
    return res.join('_')
  end

  def sauvegarder()
    dump = YAML::dump(self)
    if(@estHypothese) then
      file = File.open('Save/temp', 'w')
    else
      file = File.open(File.path('Save/'+self.getSaveName()), 'w')
    end
    file.puts dump
    file.close
  end

  def charger()
    return save
  end

  def Sauvegarde.deleteAllSave()
    Dir.glob('Save/*').each do |f|
      File.delete(f)
    end
  end

end
