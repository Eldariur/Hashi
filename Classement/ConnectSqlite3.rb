require "active_record"

ActiveRecord::Base.establish_connection(

  :adapter => "sqlite3",
  :database => "data.sqlite",
  :timeout => 3600

)
