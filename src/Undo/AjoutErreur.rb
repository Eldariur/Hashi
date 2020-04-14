			btnAide.signal_connect('clicked') {
				if(messageLabel != nil)
					vbox.remove(messageLabel)
				end
				
				nbErreur = @gene.trouverErreurs(@grilleTest)
				print(nbErreur)
				if(nbErreur > 0)	
					ajouterMessage(vbox,"Vous avez nb erreur " + nbErreur.to_s)
					#vbox.add(btnAideVisu)
					tbl.attach(vbox,0,1,2,10)
				
				#else
				#	vbox.remove(btnAideVisu)
				#	vbox.add(btnAideTxt)
				#	vbox.add(btnAideVisu)
				#	tbl.attach(vbox,0,1,2,10)
				end
				self.show_all


			}

