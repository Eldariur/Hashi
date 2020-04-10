require_relative "../Classement/Classement.rb"
require_relative "../Classement/ConnectSqlite3.rb"

class FenetreClassement < Gtk::Box

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

      @boxMenuClassement = Gtk::Box.new(Gtk::Orientation::HORIZONTAL)
      @boxMenuClassement.halign = Gtk::Align::CENTER

      @boxMenuClassement.add(@boutonFacile)
      @boxMenuClassement.add(@boutonNormal)
      @boxMenuClassement.add(@boutonDifficile)
      @boxMenuClassement.add(@boutonRetour)

      self.add(@boxMenuClassement)

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

  end

  def ajouterLig(pseudo = "",scr = "0")
    @nbLig +=1
    @rang += 1
    @tbl.resize(@nbCol,@nbLig)
    @tbl.attach(UnLabelPerso.new(@rang.to_s,"UnLabelClassement"),0,1,@nbLig,@nbLig+1)
    @tbl.attach(UnLabelPerso.new(pseudo,"UnLabelClassement"),1,3,@nbLig,@nbLig+1)
    @tbl.attach(UnLabelPerso.new(scr,"UnLabelClassement"),3,4,@nbLig,@nbLig+1)

    @@fenetre.changerWidget(self)
  end

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

  def resetAffichage()
    @nbLig = 0
    @rang = 0
    @tbl.resize(@nbCol,@nbLig)
  end


  def initBoutonFacile
    @boutonFacile = UnBoutonPerso.new("Facile","BoutonClassement")do
      verrouilleToi(@boutonFacile)
    end
  end

  def initBoutonNormal
    @boutonNormal = UnBoutonPerso.new("Normal","BoutonClassement")do
      verrouilleToi(@boutonNormal)
    end
  end

  def initBoutonDifficile
    @boutonDifficile = UnBoutonPerso.new("Difficile","BoutonClassement")do
      verrouilleToi(@boutonDifficile)
    end
  end

  def initBoutonRetour
    @boutonRetour = UnBoutonPerso.new("Retour","BoutonClassement")do
      @@fenetre.changerWidget(@@fenPre);
    end
  end

  def verrouilleToi(bouton)
    @boutonFacile.deverrouiller()
    @boutonNormal.deverrouiller()
    @boutonDifficile.deverrouiller()
    bouton.verrouiller()
  end

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
