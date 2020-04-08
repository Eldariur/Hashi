require 'yaml'

# Cette classe représente une sauvegarde.
class Sauvegarde
  #@grille -> La grille sauvegardé.
  #@grilleComplete -> La grille de départ de la grille sauvegardé
  #@chronometre -> Le chronomètre sauvegardé.
  #@estHypothese -> Si la sauvegarde est une hypothèse ou non.
  #@difficulte -> La difficulte de la sauvegarde.

  # Privatise le new.
  private_class_method :new

  # Initialisation de la class Sauvegarde.
  # === Parametre
  # * +grille+ : grille La grille à sauvegarder.
  # * +grilleComplete+ : grilleComplete La grille de départ de la grille à sauvegarder.
  # * +chrono+ : chrono Le chronomètre à sauvegarder.
  # * +difficulte+ : difficulte La difficulte de la grille.
  # * +hypothese+ : hypothese Le choix d'une sauvegarde pour une hypothèse ou non.
  def initialize(grille, grilleComplete, chrono, difficulte, hypothese = false)
    @grille = grille
    @grilleComplete = grilleComplete
    @estHypothese = hypothese
    if(@estHypothese == false) then
      @chronometre = chrono
      @difficulte = difficulte
    else
      @chronometre = nil
      @difficulte = nil
    end
  end

  # Créer un nouveau chronomètre.
  # === Parametre
  # * +grille+ : grille La grille à sauvegarder.
  # * +grilleComplete+ : grilleComplete La grille de départ de la grille à sauvegarder.
  # * +chrono+ : chrono Le chronomètre à sauvegarder.
  # * +difficulte+ : difficulte La difficulte de la grille.
  # * +hypothese+ : hypothese Le choix d'une sauvegarde pour une hypothèse ou non.
  def Sauvegarde.nouvelle(grille, grilleComplete, chrono, difficulte, hypothese = false)
    new(grille, grilleComplete, chrono, difficulte, hypothese)
  end

  # Accesseur get sur l'attribut grille.
  attr:grille, false
  # Accesseur get sur l'attribut grilleComplete.
  attr:grilleComplete, false
  # Accesseur get et set sur l'attribut chronometre.
  attr:chronometre, true
  # Accesseur get sur l'attribut estHypothese.
  attr:estHypothese, false
  # Accesseur get sur l'attribut estHypothese.
  attr:difficulte, false

  # Renvoie le chronomètre de la sauvegarde.
  # === Return
  # * +@chronometre+ : @chronometre Le chronomètre de la sauvegarde.
  def getChrono()
    return @chronometre
  end

  # Effectue les opérations de sauvegarde sur une sauvegarde.
  def sauvegarder()
    Sauvegarde.genenerDossier();
    dump = YAML::dump(self)
    if(@estHypothese) then
      file = File.open(File.path('../Sauvegarde/Save/temp.sav'), 'w')
    else
      case @difficulte
      when "easy"
        file = File.open(File.path('../Sauvegarde/Save/easy/save.sav'), 'w')
      when "normal"
        file = File.open(File.path('../Sauvegarde/Save/normal/save.sav'), 'w')
      when "hard"
        file = File.open(File.path('../Sauvegarde/Save/hard/save.sav'), 'w')
      when "custom"
        file = File.open(File.path('../Sauvegarde/Save/custom/save.sav'), 'w')
      end
    end
    file.write dump
    file.close
  end

  # Permet de sauvegarder avec un nom spécifique.
  def sauvegarderAvecNom(nom)
    dump = YAML::dump(self)
    file = File.open(File.path(nom), 'w')
    file.write dump
    file.close
  end

  # Charge une sauvegarde depuis un fichier en fonction du type de sauvegarde.
  # === Return
  # * +save+ : save La sauvegarde chargée.
  def charger()
    if(@estHypothese) then
      save = YAML.load(File.read('../Sauvegarde/Save/temp.sav'))
    else
      case @difficulte
      when "easy"
          save = YAML.load(File.read('../Sauvegarde/Save/easy/save.sav'))
        when "normal"
          save = YAML.load(File.read('../Sauvegarde/Save/normal/save.sav'))
        when "hard"
          save = YAML.load(File.read('../Sauvegarde/Save/hard/save.sav'))
        when "custom"
          save = YAML.load(File.read('../Sauvegarde/Save/custom/save.sav'))
      end
    end
    return save
  end

  # Permet de créer une hypothèse.
  def Sauvegarde.nouvelleHypothese(grille)
    save = Sauvegarde.nouvelle(grille,nil,nil,nil,true)
    save.sauvegarder()
  end

  # Permet de valider une hypothèse.
  def Sauvegarde.validerHypothese()
    File.delete('../Sauvegarde/Save/temp.sav')
  end

  # Annule une hypothèse en cours et retourne l'ancienne grille pre-hypothèse.
  # === Return
  # * +save.grille+ : save.grille La grille de la sauvegarde.
  def Sauvegarde.annulerHypothese(mode = true)
    save = Sauvegarde.nouvelle(nil,nil,nil,nil,true).charger()
    if(mode) then
      File.delete('../Sauvegarde/Save/temp.sav')
    end
    return save.grille
  end

  # Génére les dossiers nécessaires au fonctionnement des sauvegardes.
  def Sauvegarde.genenerDossier()
    if(!Dir.exist?('Save')) then
      Dir::mkdir("Save", 0777)
    end
    if(!Dir.exist?('Save/easy')) then
      Dir::mkdir("Save/easy", 0777)
    end
    if(!Dir.exist?('Save/normal')) then
      Dir::mkdir("Save/normal", 0777)
    end
    if(!Dir.exist?('Save/hard')) then
      Dir::mkdir("Save/hard", 0777)
    end
    if(!Dir.exist?('Save/custom')) then
      Dir::mkdir("Save/custom", 0777)
    end
  end

  # Permet de supprimer toutes les sauvegardes.
  def Sauvegarde.deleteAllSave()
    Dir.glob('**/*.sav').each do |e|
      puts "Removed : "+e.to_s
      if(File.file?(e)) then
        File.delete(e)
      end
    end
  end

  # Cette méthode redefini to_s pour afficher une sauvegarde.
  def to_s
    if(@estHypothese) then
      "Sauvegarde : \n-Grille :\n#{@grille}-estHypo = #{@estHypothese}\n---------------------------------------------------\n"
    else
      "Sauvegarde : \n-Grille :\n#{@grille}-Grille de depart :\n#{@grilleComplete}-estHypo = #{@estHypothese}\n-Chrono = #{@chronometre} \n-Difficulte = #{@difficulte}\n---------------------------------------------------\n"
    end
  end

end
