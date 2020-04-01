load "Classement.rb"
load "../Chrono/Chronometre.rb"
require "./ConnectSqlite3.rb"

c = Chrono.nouveau()

threads = []
threads << Thread.new {c.chronometrer()}
threads << Thread.new {stopsaisie(c)}

threads.each { |thr| thr.join }

s = Score.creer()
s.setTime(c.resultat())
s.setName()

for i in 0..rand(2)
  s.addMalus(rand(20))
end

s.calculScore(100)

c = Classement.creer()

c.recupererDonnees()
puts c

s.sauvegarder()
puts s
