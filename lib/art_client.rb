require 'sinatra/base'
require 'arts_gallery_api'

class ArtClient < Sinatra::Base
  use Rack::Static, :urls => ['/css'], :root => 'public'



  get '/' do
    erb :index
  end

  get '/galleries' do
    erb :galleries
  end

  get '/exhibitions' do
    
    erb :exhibitions
  end

  get "/exhibitions/:exhibition_id/ticket_form" do
   
    erb :ticket_form
  end
end


