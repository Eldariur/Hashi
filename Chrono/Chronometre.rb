# Cette classe represente un chronomètre.
class Chrono < Gtk::Label
  #@stop -> Permet de stopper le chronomètre.
  #@total -> Contient le total de secondes écoulées.
  #@base -> Permet de sauvegarder le temps a partir du quel on chronomètre.
  #@temp -> Permet de pouvoir relancer le chronomètre avec une valeur deja existante.

  # Privatise le new.
	private_class_method :new

  # Initialisation de la class Chronometre.
  def initialize()
    @stop = 0
    @total = 0
    @base = 0
    @temp = 0
	super(self.to_s)
  end

  # Creer un nouveau chronomètre.
  def Chrono.nouveau()
    new()
  end

	# Accesseur get sur l'attribut stop.
  attr:stop, false
	# Accesseur get et set sur l'attribut total.
  attr:total, true
	# Accesseur get sur l'attribut base.
  attr:base, false
	# Accesseur get sur l'attribut temp.
  attr:temp, false

  # Remet à 0 le chronomètre.
  def reset()
    @base = Time.now()
    @stop = 0
    @temp = 0
  end

  # Lance le chronometrage.
  def chronometrer()
    self.reset()
    if(@total != 0) then
      @temp = @total
    end
    while @stop != 1 do
      @total = Time.now - @base
      #puts `clear`
      #puts self.to_chrono()
      sleep(0.01)
	self.text = self.to_s()
    end
  end

  # Permet d'arreter le chronomètre.
  def arreter()
    @stop = 1
  end

  # Retourne la valeur du chronomètre.
	# === Return
	# * +resultat+ : resultat La valeur calculée du chronomètre.
  def resultat()
    return @total + @temp
  end

  # Transforme les secondes en un affichage de chronomètre.
	# === Return
	# * +res+ : res Une chaine de caractère qui contient l'affichage.
	def to_chrono()
		minZero = ""
		secZero = ""
    s = self.resultat()

    sec = s.to_i%60
    #ms = (((s-sec)*1000)%1000).to_i
    min = (s.to_i/60)%60
    tmin = (s.to_i/60)
    hr = tmin.to_i/60
		if(min.to_s.size == 1)
			minZero = "0"
		end
		if(sec.to_s.size == 1)
			secZero = "0"
		end
    res = minZero + min.to_s + ':' + secZero + sec.to_s

    return res
  end

	# Cette methode redefini to_s pour afficher un chronometre.
	def to_s()
		self.to_chrono()
	end

end

# Methode de test pour arreter le chronomètre en fonction d'un temps en secondes donné.
# === Parametre
# * +t+ : t Le temps pour temporiser.
# * +c+ : c Le chronomètre.
def stoptemps(t,c)
  t.times do
    sleep(1)
  end
  puts 'STOP'
  c.arreter()
end

# Methode de test pour arreter le chronomètre en fonction de l'appuie sur une touche.
# === Parametre
# * +c+ : c Le chronomètre.
def stopsaisie(c)
  test = nil
  while(test == nil) do
    test = gets
  end
  c.arreter()
end
