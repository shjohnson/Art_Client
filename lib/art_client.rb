require 'sinatra/base'
require 'arts_gallery_api'

class ArtClient < Sinatra::Base
  use Rack::Static, :urls => ['/css'], :root => 'public'



  get '/' do
    gallery = ArtsGalleryApi::Gallery.new 
    gallery.all["galleries"].each do |gallery_hash| 
    gallery_number = gallery_hash['id'] 
    data = gallery.retrieve_a_gallery(gallery_number)
    end 
    erb :index
  end

  get '/galleries' do
    erb :galleries
  end

  get '/exhibitions' do

    erb :exhibitions
  end

  get '/gallery_view' do
    gallery = ArtsGalleryApi::Gallery.new 
    @galleries = gallery.all["galleries"]
    # gallery_name = 
    erb :gallery_view
  end

  get "/exhibitions/:exhibition_id/ticket_form" do

    erb :ticket_form
  end
end


