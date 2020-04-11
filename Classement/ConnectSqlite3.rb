require "active_record"

ActiveRecord::Base.establish_connection(

  :adapter => "sqlite3",
  :database => "../Classement/data.sqlite",
  :timeout => 3600

)
