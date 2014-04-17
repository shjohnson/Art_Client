require 'sinatra/base'
require 'arts_gallery_api'

class ArtClient < Sinatra::Base
  use Rack::Static, :urls => ['/css'], :root => 'public'

  gallery_api = ArtsGalleryApi::Gallery.new
  ticket_api = ArtsGalleryApi::Ticket.new

  helpers do
    def gallery_index
      gallery_index ||= ArtsGalleryApi::Gallery.new.all["galleries"]
    end

    def connector
      connector ||= ArtsGalleryApi::Gallery.new
    end

    def select_gallery(number)
      puts("getting single gallery #{number}")
        ArtsGalleryApi::Gallery.new.retrieve_a_gallery(number)
    end
  end

  get '/' do
    erb :index
  end

  get '/galleries' do
      @connector = gallery_api
   erb :galleries
 end

 get '/gallery_view/:gallery_id' do
  id = params[:gallery_id]
  puts "getting single gallery #{id} in action"
  @gallery = gallery_api.retrieve_a_gallery(id)
  puts "getting all exhibitions for gallery #{id}"
  exhibition_index = connector.get_gallery_exhibitions(id)["exhibitions"]

  @exhibitions = exhibition_index.collect do |exhibition|
    exhibition_number = exhibition["id"]
    puts "getting exhibition data for #{exhibition_number}"
    connector.get_exhibition(exhibition_number)
  end

  erb :gallery_view
 end

  get "/exhibitions/:exhibition_id/ticket_form/:gallery_id" do
    @gallery_name = gallery_api.retrieve_a_gallery(params[:gallery_id])['name']
    @opens = gallery_api.retrieve_a_gallery(params[:gallery_id])["opening_hour"]
    @closes = gallery_api.retrieve_a_gallery(params[:gallery_id])["closing_hour"]

    erb :ticket_form
  end

  post "/ticket" do
    ticket = ArtsGalleryApi::Ticket.new
    result = ticket.create_a_ticket(params[:name], params[:id].to_i, "#{params[:date]} #{params[:time]}") 
    erb :ticket
  end
end




















