load "Classement.rb"
load "../Chrono/Chronometre.rb"
require "./ConnectSqlite3.rb"

c = Chrono.nouveau()

threads = []
threads << Thread.new {c.chronometrer()}
threads << Thread.new {stopsaisie(c)}

threads.each { |thr| thr.join }

s = Score.creer(Score.askName, c.resultat,"easy")

for i in 0..rand(5)
  s.addMalus(rand(20))
end

s.calculScore(100)

puts "Nouveau : #{s}"

c = Classement.creer(s.difficulte)

puts "BDD avant :\n#{c.to_s}"

if c.isHighScore(s) then s.sauvegarder() end

puts "BDD apres :\n#{c.to_s}"
