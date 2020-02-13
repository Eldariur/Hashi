# require_relative "Fenetre1.rb"

class UneCasePerso < UnBoutonPerso

  def initialize(str="", coordX=nil, coordY=nil)
    super(str)
    @x = coordX
    @y = coordY
    @@x2 = nil
    @@y2 = nil

    self.signal_connect('clicked'){
      if(@x == @@x2 || @y == @@y2)
        puts "case sur les même coordonnées x = "+@x.to_s+" y = "+@y.to_s+" x2 = "+@@x2.to_s+" y2 = "+@@y2.to_s
      else
        puts "c'est une case vide de coordonnée x = "+@x.to_s+" y = "+@y.to_s+" x2 = "+@@x2.to_s+" y2 = "+@@y2.to_s

      end
      @@x2 = @x
      @@y2 = @y
    }
  end

  attr_accessor :x2, :y2


end
