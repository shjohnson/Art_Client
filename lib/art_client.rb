require 'sinatra/base'
require 'arts_gallery_api'

class ArtClient < Sinatra::Base
  use Rack::Static, :urls => ['/css'], :root => 'public'

  helpers do
    def gallery_index
      @gallery_index ||= ArtsGalleryApi::Gallery.new.all["galleries"]
    end
  end

  get '/' do
    erb :index
  end

  get '/galleries' do
     connector = ArtsGalleryApi::Gallery.new
     gallery_index ||= ArtsGalleryApi::Gallery.new.all["galleries"]
     gallery_index.collect do |gallery_hash| 
     id = gallery_hash['id']
     @gallery = connector.retrieve_a_gallery(id)
     require 'pry'; binding.pry
  end


     erb :galleries
   end

   get '/gallery_view/:gallery_id' do

    id = params[:gallery_id]
    connector = ArtsGalleryApi::Gallery.new
    @gallery = connector.retrieve_a_gallery(id)
    exhibition_index = connector.get_gallery_exhibitions(id)["exhibitions"]
    
    @exhibitions = exhibition_index.collect do |exhibition|
      exhibition_number = exhibition["id"]
      connector.get_exhibition(exhibition_number)
    end

    erb :gallery_view
  end

  get "/exhibitions/:exhibition_id/ticket_form" do

    erb :ticket_form
  end
end


