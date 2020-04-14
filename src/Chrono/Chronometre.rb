require 'gtk3'

# Cette classe représente un chronomètre.
class Chrono < Gtk::Label
  #@stop -> Permet de stopper le chronomètre.
  #@total -> Contient le total de secondes écoulées.
  #@base -> Permet de sauvegarder le temps à partir duquel on chronomètre.
  #@temp -> Permet de pouvoir relancer le chronomètre avec une valeur déjà existante.
  #@malus -> Le malus en secondes du chronomètre.
  #@th -> Le Thread du chronomètre.

	# Accesseur get sur l'attribut stop.
	attr:stop, false
	# Accesseur get sur l'attribut total.
	attr:total, false
	# Accesseur get sur l'attribut base.
	attr:base, false
	# Accesseur get sur l'attribut temp.
	attr:temp, false
	# Accesseur get sur l'attribut malus.
	attr:malus, false
	# Accesseur get sur l'attribut th.
	attr:th, false

  # Privatise le new.
	private_class_method :new

  # Initialisation de la class Chronometre.
  def initialize()
    @stop = 0
    @total = 0
    @base = 0
    @temp = 0
		@malus = 0
		super(self.to_s)
  end

  # Créer un nouveau Chronometre.
  def Chrono.nouveau()
    new()
  end

  # Remet à 0 le chronomètre.
  def reset()
    @base = Time.now()
    @stop = 0
    @temp = 0
  end

  # Lance le chronométrage.
  def chronometrer(affichage = false)
		@th = Thread.new {
	    self.reset()
	    if(@total != 0) then
	      @temp = @total
	    end
	    while @stop != 1 do
	      @total = Time.now - @base
				if(affichage) then
		     puts `clear`
		     puts self.to_chrono()
				end
	      sleep(0.01)
				self.text = self.to_s()
	    end
		}
  end

  # Permet d'arrêter le chronomètre.
  def arreter()
    @stop = 1
  end

  # Retourne la valeur du chronomètre.
	# === Return
	# * +resultat+ : resultat La valeur calculée du chronomètre.
  def resultat()
    return @total + @temp + @malus
  end

	# Cette méthode ajoute du malus dans un chronomètre.
	# === Paramètres
	# * +val+ : val La valeur de malus.
	def addMalus(val)
		@malus += val
	end

	# Cette méthode remet à zéro le malus dans un chrono.
	def resetMalus()
		@malus = 0
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

	@Override
	# Cette méthode redéfinit to_s pour afficher un chronomètre.
	def to_s()
		self.to_chrono()
	end

	# Cette méthode termine le thread du chronomètre.
	def fin()
		@th.join
		@th.kill
	end

	# Cette méthode retourne si le thread du chronomètre est en cours d'éxécution.
	# === Return
	# * +@th.alive?+ : @th.alive?() Un boolean représentant le résultat.
	def vivant?()
		return @th.alive?()
	end

end

# Méthode de test pour arrêter le chronomètre en fonction d'un temps en secondes donné.
# === Paramètres
# * +t+ : t Le temps pour temporiser.
# * +c+ : c Le chronomètre.
def stoptemps(t,c)
  t.times do
    sleep(1)
  end
  c.arreter()
end

# Méthode de test pour arrêter le chronomètre en fonction de l'appuie sur une touche.
# === Paramètres
# * +c+ : c Le chronomètre.
def stopsaisie(c)
  test = nil
  while(test == nil) do
    test = gets
  end
  c.arreter()
end
