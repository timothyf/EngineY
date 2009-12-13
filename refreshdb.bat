start /wait /B rake db:drop:all
start /wait /B rake db:create:all
start /wait /B rake db:migrate
start /wait /B rake railsnet:db:populate

