load "Classement.rb"
load "../Chrono/Chronometre.rb"
require "./ConnectSqlite3.rb"

c = Chrono.nouveau()


threads = []
threads << Thread.new {c.chronometrer()}
threads << Thread.new {stopsaisie(c)}

threads.each { |thr| thr.join }

s = Score.creer(Score.askName, c.resultat)

for i in 0..rand(5)
  s.addMalus(rand(20))
end

s.calculScore(100)

puts "Nouveau : #{s}"
puts s.inspect()

s.sauvegarder()

c = Classement.creer()

c.recupererDonnees()
puts c.to_s
