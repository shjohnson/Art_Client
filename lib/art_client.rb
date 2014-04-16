require 'sinatra/base'
require 'arts_gallery_api'

class ArtClient < Sinatra::Base
  use Rack::Static, :urls => ['/css'], :root => 'public'



  get '/' do
    gallery = ArtsGalleryApi::Gallery.new
    @gallery_index = gallery.all["galleries"]
    erb :index
  end

  get '/galleries' do
    erb :galleries
  end

  get '/exhibitions' do

    erb :exhibitions
  end

  get '/gallery_view/:gallery_id' do
    params[:gallery_id]
    @id =(params[:gallery_id].to_i - 1)
    @gallery = ArtsGalleryApi::Gallery.new
    gallery_index = @gallery.all["galleries"]
    @galleries = gallery_index.collect do |data_hash|
      id = data_hash["id"]
      @gallery.retrieve_a_gallery(id)
    end

    @exhibition_details= @gallery.get_gallery_exhibitions(params[:gallery_id])["exhibitions"]

    erb :gallery_view
  end

  get "/exhibitions/:exhibition_id/ticket_form" do

    erb :ticket_form
  end
end


