class Tutoriel

attr_reader :txtTuto

def initialize(numeroNiveau)
	@niveau = numeroNiveau
	@txtTuto = nil
end
	## Méthode permettant
	  #
	  # === Return
	  #
	  # L'aide textuelle correspondant à l'id de l'aide appelante
	def getMessageTuto()
		file_data = File.read("../Tutoriel/TextTuto.txt").split("/").join(":").split(":")
		@txtTuto = file_data
		#puts file_data
		affiche = false

		file_data.each do |x|
	        	if( affiche )
	                	return x

			elsif( x == "\n"+@niveau.to_s)
				affiche = true
			end
		end
	end

	def lancerTuto()
		tuto = YAML.load(File.read('../Tutoriel/Niveaux/'+@niveau.to_s+'.sav'))

		return tuto
	end
end
