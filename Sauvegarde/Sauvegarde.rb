require 'yaml'

# Cette classe represente un sauvegarde.
class Sauvegarde
  #@grille -> La grille sauvegardé.
  #@grilleDepart -> La grille de départ de la grille sauvegardé
  #@chronometre -> Le chronometre sauvegardé.
  #@estHypothese -> Si la sauvegarde est une hypothese ou non.
  #@difficulte -> La difficulte de la sauvegarde.

  # Privatise le new.
  private_class_method :new

  # Initialisation de la class Sauvegarde.
  # === Parametre
  # * +grille+ : grille La grille a sauvegarder.
  # * +grilleDepart+ : grilleDepart La grille de départ de la grille a sauvegarder.
  # * +chrono+ : chrono Le chronometre a sauvegarder.
  # * +difficulte+ : difficulte La difficulte de la grille.
  # * +hypothese+ : hypothese Le choix d'une sauvegarde pour une hypothese ou non.
  def initialize(grille, grilleDepart, chrono, difficulte, hypothese = false)
    @grille = grille
    @grilleDepart = grilleDepart
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
  # * +difficulte+ : difficulte La difficulte de la grille.
  # * +hypothese+ : hypothese Le choix d'une sauvegarde pour une hypothese ou non.
  def Sauvegarde.nouvelle(grille, grilleDep, chrono, difficulte, hypothese = false)
    new(grille, grilleDep, chrono, difficulte, hypothese)
  end

  # Accesseur get sur l'attribut grille.
  attr:grille, false
  # Accesseur get sur l'attribut grilleDepart.
  attr:grilleDepart, false
  # Accesseur get et set sur l'attribut chronometre.
  attr:chronometre, true
  # Accesseur get sur l'attribut estHypothese.
  attr:estHypothese, false
  # Accesseur get sur l'attribut estHypothese.
  attr:difficulte, false

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

  # Effectue les opération de sauvegarde sur une sauvegarde.
  def sauvegarder()
    dump = YAML::dump(self)
    puts @estHypothese
    if(@estHypothese) then
      puts "yolo0"
      file = File.open(File.path('../Sauvegarde/Save/temp.sav'), 'w')
    else
      case @difficulte
      when "easy"
          file = File.open(File.path('../Sauvegarde/Save/easy/save.sav'), 'w')
        when "normal"
          file = File.open(File.path('../Sauvegarde/Save/normal/save.sav'), 'w')
        when "hard"
          file = File.open(File.path('../Sauvegarde/Save/hard/save.sav'), 'w')
        end
    end
    puts "yolo #{file}"
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
      end
    end
    return save
  end

  # Permet de créer une hypothese.
  def Sauvegarde.nouvelleHypothese(grille)
    save = Sauvegarde.nouvelle(grille,nil,nil,nil,true)
    save.sauvegarder()
  end

  # Permet de valider une hypothese.
  def Sauvegarde.validerHypothese()
    File.delete('../Sauvegarde/Save/temp.sav')
  end

  # Annule une hypothese en cours et retourne l'ancienne grille pre-hypothese.
  # === Return
  # * +save.getGrille()+ : save.getGrille() La grille de la sauvegarde.
  def Sauvegarde.annulerHypothese(mode = true)
    save = Sauvegarde.nouvelle(nil,nil,nil,nil,true).charger()
    if(mode) then
      File.delete('../Sauvegarde/Save/temp.sav')
    end
    return save.getGrille()
  end

  # Genere les dossiers necessaire au fonctionnement des sauvegardes.
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

  # Cette methode redefini to_s pour afficher une sauvegarde.
  def to_s
    if(@estHypothese) then
      "Sauvegarde : \n-Grille :\n#{@grille}-estHypo = #{@estHypothese}\n---------------------------------------------------\n"
    else
      "Sauvegarde : \n-Grille :\n#{@grille}-Grille de depart :\n#{@grilleDepart}-estHypo = #{@estHypothese}\n-Chrono = #{@chronometre} \n-Difficulte = #{@difficulte}\n---------------------------------------------------\n"
    end
  end

end
