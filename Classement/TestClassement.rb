require_relative "../Classement/Classement.rb"
require_relative "../Chrono/Chronometre.rb"
require_relative "../Classement/ConnectSqlite3.rb"

c = Chrono.nouveau()

threads = []
threads << Thread.new {c.chronometrer()}
threads << Thread.new {stopsaisie(c)}

threads.each { |thr| thr.join }

# Uniquement besoin pour le test pour simuler une partie
for i in 0..rand(3)
  c.addMalus(rand(15))
end
c.addMalus(30)

s = Score.creer(Score.askName, c.resultat,"normal")

# Uniquement besoin pour le test pour afficher a la fin
cl =  Classement.creer(s.difficulte)

s.calculScore()

puts "Nouveau : #{s}"

puts "BDD avant :\n#{cl.to_s}"

s.sauvegarder

puts "BDD apres :\n#{cl.to_s}"

=begin
20.times do

  temp = (0...3).map { (65 + rand(26)).chr }.join
  temp2 = (0...3).map { (65 + rand(26)).chr }.join
  temp3 = (0...3).map { (65 + rand(26)).chr }.join

  for i in 0..rand(3)
    c.addMalus(rand(15))
  end

  c.addMalus(30)

  s = Score.creer(temp, c.resultat,"easy")
  s2 = Score.creer(temp2, c.resultat,"normal")
  s3 = Score.creer(temp3, c.resultat,"hard")

  s.calculScore(60)
  s2.calculScore(90)
  s3.calculScore(120)

  puts "Nouveau : #{s}"
  puts "Nouveau : #{s2}"
  puts "Nouveau : #{s3}"

  s.sauvegarder
  s2.sauvegarder
  s3.sauvegarder

  c.resetMalus()
end

puts "BDD avant :\n#{c.to_s}"

if c.isHighScore(s) then s.sauvegarder() end

puts "BDD apres :\n#{c.to_s}"
=end
