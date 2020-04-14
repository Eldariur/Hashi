require "active_record"

# Ce fichier permet de défninir les options de connexion à la base de données.
ActiveRecord::Base.establish_connection(

  :adapter => "sqlite3",
  :database => "./src/Classement/data.sqlite",
  :timeout => 3600

)
