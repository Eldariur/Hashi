require_relative "../Chrono/Chronometre.rb"

c = Chrono.nouveau()

threads = []
threads << Thread.new {c.chronometrer()}
threads << Thread.new {stopsaisie(c)}
#threads << Thread.new {stoptemps(3,c)}

threads.each { |thr| thr.join }
puts 'Resultat : '+ c.to_chrono() + ' | Total : ' + c.resultat().to_s

#c.chronometrer()
