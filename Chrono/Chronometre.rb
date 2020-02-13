class Chrono
  #@stop
  #@total
  #@base

  attr:stop, false
  attr:total, true
  attr:base, false

  def initialize()
    @stop = 0
    @total = 0
    @base = 0
  end

  #Remet à 0 le chronomètre.
  def reset()
    @total = 0
    @base = Time.now()
    @stop = 0
  end

  #Lance le chronometrage et renvoie le resultat en secondes.
  def chronometrer()
    self.reset()
    while @stop != 1 do
      @total = Time.now - @base
      puts `clear`
      puts self.to_chrono()
      sleep(0.01)
    end
  end

  #Permet d'arreter le chronomètre.
  def arreter()
    @stop = 1
  end

  #Retourne la valeur du chronomètre.
  def resultat()
    return @total
  end

  #Transforme les secondes en un affichage de chronomètre.
  def to_chrono()
    s = self.resultat()

    sec = s.to_i%60
    ms = (((s-sec)*1000)%1000).to_i
    min = s.to_i/60
    hr = min.to_i/60
    res = hr.to_s + 'h ' + min.to_s + 'min ' + sec.to_s + 's ' + ms.to_s + 'ms'

    return res
  end
end

#Methode de test pour arreter le chronomètre en fonction d'un temps en secondes donné.
def stoptemps(t,c)
  t.times do
    sleep(1)
  end
  puts 'STOP'
  c.arreter()
end

#Methode de test pour arreter le chronomètre en fonction de l'appuie sur une touche.
def stopsaisie(c)
  test = nil
  while(test == nil) do
    test = gets
  end
  c.arreter()
end
