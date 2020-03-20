load "Classement.rb"
load "../Chrono/Chronometre.rb"
require "ConnectSqlite3.rb"



=begin
ary = Array.new

for i in 0..9
   ary.push(Score.creer(i.to_s,0,rand(i*10+1),rand(i+1)))
   ary[i].calculScore(100)
end

ary.each do |n|
    puts n
end
=end

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
s.sauvegarder()
puts s
