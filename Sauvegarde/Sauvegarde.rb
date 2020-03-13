require 'yaml'

# Cette classe represente un sauvegarde.
class Sauvegarde
  #@grille -> La grille sauvegardé.
  #@chronometre -> Le chronometre sauvegardé.
  #@estHypothese -> Si la sauvegarde est une hypothese ou non.
  #@difficulte -> La difficulte de la sauvegarde.

  # Privatise le new.
  private_class_method :new

  # Initialisation de la class Sauvegarde.
  # === Parametre
  # * +grille+ : grille La grille a sauvegarder.
  # * +chrono+ : chrono Le chronometre a sauvegarder.
  # * +hypothese+ : hypothese Le choix d'une sauvegarde pour une hypothese ou non.
  def initialize(grille, chrono, difficulte, hypothese = false)
    @grille = grille
    @estHypothese = hypothese
    if(@estHypothese == false) then
      @chronometre = chrono
      @difficulte = difficulte
    else
      @chronometre = nil
      @difficulte = nil
    end
  end

  # Creer un nouveau chronomètre.
  # === Parametre
  # * +grille+ : grille La grille a sauvegarder.
  # * +chrono+ : chrono Le chronometre a sauvegarder.
  # * +hypothese+ : hypothese Le choix d'une sauvegarde pour une hypothese ou non.
  def Sauvegarde.nouvelle(grille, chrono, difficulte, hypothese = false)
    new(grille, chrono, difficulte, hypothese)
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
  # * +@chronometre+ : @chronometre Le chronometre de la sauvegarde.
  def getChrono()
    return @chronometre
  end

  # Renvoie la grille de la sauvegarde.
  # === Return
  # * +@grille+ : @grille La grille de la sauvegarde.
  def getGrille()
    return @grille
  end

  def sauvegarder()
    dump = YAML::dump(self)
    if(@estHypothese) then
      file = File.open(File.path('Save/temp.sav'), 'w')
    else
      case @difficulte
        when 1
          file = File.open(File.path('Save/easy/save.sav'), 'w')
        when 2
          file = File.open(File.path('Save/normal/save.sav'), 'w')
        when 3
          file = File.open(File.path('Save/hard/save.sav'), 'w')
        end
    end
    file.write dump
    file.close
  end

  def charger()
    if(@estHypothese) then
      save = YAML.load(File.read('Save/temp.sav'))
    else
      case @difficulte
        when 1
          save = YAML.load(File.read('Save/easy/save.sav'))
        when 2
          save = YAML.load(File.read('Save/normal/save.sav'))
        when 3
          save = YAML.load(File.read('Save/hard/save.sav'))
      end
    end
    return save
  end

  def Sauvegarde.nouvelleHypothese(grille)
    save = Sauvegarde.nouvelle(grille,nil,nil,true)
    save.sauvegarder()
  end

  def Sauvegarde.validerHypothese()
    File.delete('Save/temp.sav')
  end

  def Sauvegarde.annulerHypothese(mode = true)
    save = Sauvegarde.nouvelle(nil,nil,nil,true).charger()
    if(mode) then
      File.delete('Save/temp.sav')
    end
    return save.getGrille()
  end

  def Sauvegarde.deleteAllSave()
    Dir.glob('**/*.sav').each do |e|
      puts "Removed : "+e.to_s
      if(File.file?(e)) then
        File.delete(e)
      end
    end
  end

  def to_s
    if(@estHypothese) then
      "Sauvegarde : \n-Grille :\n#{@grille}-estHypo = #{@estHypothese}\n---------------------------------------------------\n"
    else
      "Sauvegarde : \n-Grille :\n#{@grille}-estHypo = #{@estHypothese}\n-Chrono = #{@chronometre} \n-Difficulte = #{@difficulte}\n---------------------------------------------------\n"
    end
  end

end
