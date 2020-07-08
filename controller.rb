require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/film')
also_reload('./models/*')

get '/film' do
    @film = Film.find_all()
    erb(:index)
end
