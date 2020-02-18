class FenetreJeu < Gtk::Box

  def initialize(window)
    @@fenetre = window
    super(Gtk::Orientation::VERTICAL)

    lbl1 = UnLabelPerso.new("Ceci est ma fenetre de jeu (en construction)")

	x=2
	y=2
	tbl = Gtk::Table.new(x,y)
  @click = 0
  @btn

  
	0.upto(x) do |i|
		0.upto(y) do |j|
		  tbl.attach(@btn = UnBoutonPerso.new("1","UneCasePerso"),i,i+1,j,j+1)

	  end
  end

  @btn.signal_connect('clicked'){
    print "hello world"
    @click+=1
    if @click > 5
      @btn.image=dimImage("./img/pont_rouge_jap.jpg")
    end
  }

    #img = Gtk::Image.new("img/jeuDeTest.png")
    self.add(lbl1)
    self.add(tbl)
    #self.add(img)
  end

  def dimImage(str)
    image = Gtk::Image.new(str)
    image.pixbuf = image.pixbuf.scale(28,28) if image.pixbuf!=nil
    return image
  end

end
