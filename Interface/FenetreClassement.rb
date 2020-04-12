require_relative "../Classement/Classement.rb"
require_relative "../Classement/ConnectSqlite3.rb"

# Classe permettant d'afficher le classement des scores
class FenetreClassement < Gtk::Box
  ## Partie variables d'instance

  # @@fenetre -> la fenêtre principale du programme
  # @@fenPrev -> la fenêtre précédente
  # @nbCol -> le nombre de colonne du classement
  # @nbLig -> le nombre de ligne du Classement
  # @rang -> le rang du pseudo dans le classement
  # @diff -> la difficulté dans lequel les scores sont enregistrés
  # @boutonFacile -> le bouton du menu du classement du mode facile
  # @boutonNormal -> le bouton du menu du classement du mode normal
  # @boutonDifficile -> le bouton du menu du classement du mode difficile
  # @boutonRetour -> le bouton permettant de revenir à la fenêtre précédente
  # @tbl -> tableau du classsement


  ## Partie initialize

  # Initialisation de la classe FenetreClassement
  #
  # === Paramètres
  #
  # * +window+ : window la fenetre principale du programme
  # * +fenPre+ : fenPre la fenetre précédente
  def initialize(window, fenPrev)
    @@fenetre = window
    @nbCol = 4
    @nbLig = 0
    @rang = 0

    @diff = ""

    @@fenPre = fenPrev

    super(Gtk::Orientation::VERTICAL)

      initClassement
      initBoutonFacile
      initBoutonNormal
      initBoutonDifficile
      initBoutonRetour

      boxMenuClassement = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
      boxMenuClassement.halign = Gtk::Align::CENTER

      boxMenuClassement.add(@boutonFacile)
      boxMenuClassement.add(@boutonNormal)
      boxMenuClassement.add(@boutonDifficile)
      boxMenuClassement.add(@boutonRetour)

      self.add(boxMenuClassement)

      @boutonFacile.signal_connect('clicked'){
        @diff = "easy"
        afficherBdd()
      }

      @boutonNormal.signal_connect('clicked'){
        @diff = "normal"
        afficherBdd()
      }

      @boutonDifficile.signal_connect('clicked'){
        @diff = "hard"
        afficherBdd()
      }

      @boutonFacile.clicked()

  end

  ## Partie méthodes

  ## Méthode avec paramètres permettant d'ajouter une ligne au classement
  #
  # === Paramètres
  #
  # * +pseudo+ : pseudo Pseudo de a personne inscrite sur le classement
  # * +scr+ : scr score de la personne inscrite sur le classement
  def ajouterLig(pseudo = "",scr = "0")
    @nbLig +=1
    @rang += 1
    @tbl.resize(@nbCol,@nbLig)
    @tbl.attach(UnLabelPerso.new(@rang.to_s,"UnLabelClassement"),0,1,@nbLig,@nbLig+1)
    @tbl.attach(UnLabelPerso.new(pseudo,"UnLabelClassement"),1,3,@nbLig,@nbLig+1)
    @tbl.attach(UnLabelPerso.new(scr,"UnLabelClassement"),3,4,@nbLig,@nbLig+1)

    @@fenetre.changerWidget(self)
  end

  ## Méthode sans paramètres permettant d'initialiser le classement
  # et de l'ajouter à la fenêtre de jeu
  def initClassement()
    @tbl = Gtk::Table.new(@nbCol,@nbLig)
    @tbl.set_name("TableDesScores")
    lbl1 = UnLabelPerso.new("RANG","UnLabelClassement")
    lbl2 = UnLabelPerso.new("Pseudo","UnLabelClassement")
    lbl3 = UnLabelPerso.new("Score","UnLabelClassement")

    @tbl.attach(lbl2,0,1,0,1)
    @tbl.attach(lbl1,1,3,0,1)
    @tbl.attach(lbl3,3,4,0,1)

    self.add(@tbl)
  end

  ## Méthode sans paramètres permettant de redimensionner le tableau du classement
  def resetAffichage()
    @nbLig = 0
    @rang = 0
    @tbl.resize(@nbCol,@nbLig)
  end

  ## Méthode sans paramètres permettant d'initialiser le bouton du menu facile du tableau du classement
  def initBoutonFacile
    @boutonFacile = UnBoutonPerso.new("Facile","BoutonClassement")do
      verrouilleToi(@boutonFacile)
    end
  end

  ## Méthode sans paramètres permettant d'initialiser le bouton du menu normal du tableau du classement
  def initBoutonNormal
    @boutonNormal = UnBoutonPerso.new("Normal","BoutonClassement")do
      verrouilleToi(@boutonNormal)
    end
  end

  ## Méthode sans paramètres permettant d'initialiser le bouton du menu difficile du tableau du classement
  def initBoutonDifficile
    @boutonDifficile = UnBoutonPerso.new("Difficile","BoutonClassement")do
      verrouilleToi(@boutonDifficile)
    end
  end

  ## Méthode sans paramètres permettant d'initialiser le bouton pour revenir au menu précédent
  def initBoutonRetour
    @boutonRetour = UnBoutonPerso.new("Retour","BoutonClassement")do
      @@fenetre.changerWidget(@@fenPre);
    end
  end

  ## Méthode avec paramètres permettant de verrouiller un bouton
  # déverouille également tous les autres boutons
  def verrouilleToi(bouton)
    @boutonFacile.deverrouiller()
    @boutonNormal.deverrouiller()
    @boutonDifficile.deverrouiller()
    bouton.verrouiller()
  end

  ## Méthode sans paramètres permettant d'afficher la base de donner
  def afficherBdd()
    self.remove(@tbl)
    self.initClassement()
    self.resetAffichage()
    c = Classement.creer(@diff)
    c.recupererDonnees()
    c.liste.each do |s|
      self.ajouterLig(s.getNom, s.getScore)
    end
  end



end
