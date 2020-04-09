require_relative "../Chrono/Chronometre.rb"

c = Chrono.nouveau()

threads = []
#threads << Thread.new {c.chronometrer()}
threads << Thread.new {stopsaisie(c)}
threads << Thread.new {stoptemps(3,c)}

c.chronometrer()

threads.each { |thr| thr.join }
puts 'Resultat : '+ c.to_chrono() + ' | Total : ' + c.resultat().to_s

sleep(1)

c.addMalus(5)
c.chronometrer()
