class Tutoriel

	## Méthode permettant
	  #
	  # === Return
	  #
	  # L'aide textuelle correspondant à l'id de l'aide appelante
	def Tutoriel.getMessageTuto(numeroNiveau)
		file_data = File.read("./TextTuto.txt").split("/").join(":").split(":")
		#puts file_data
		affiche = false

		file_data.each do |x|
	        	if( affiche )
	                	return x
			
			elsif( x == "\n"+numeroNiveau)
				affiche = true
			end
		end
	end
end

