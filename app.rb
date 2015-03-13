require "sinatra"
require "pry-byebug"
require "awesome_print"
require "json"


JASPER = [
  { title: "background-image", url: "https://igcdn-photos-h-a.akamaihd.net/hphotos-ak-xaf1/t51.2885-15/11055462_513059302165903_1753383686_n.jpg"},
  { title: "boxes", url: "https://igcdn-photos-h-a.akamaihd.net/hphotos-ak-xaf1/t51.2885-15/11005233_1387122404937847_746701829_n.jpg" },
  { title: "mint", url: "https://igcdn-photos-h-a.akamaihd.net/hphotos-ak-xaf1/t51.2885-15/11005122_403944089779711_82071826_n.jpg" },
  { title: "sun", url: "https://igcdn-photos-e-a.akamaihd.net/hphotos-ak-xaf1/t51.2885-15/10983603_463941597092988_1681238831_n.jpg" }
]

class App < Sinatra::Base

  enable :sessions, :logging

  before do
    @background_image = JASPER.map { |hash| hash[:url] if hash[:title] == "background-image" }.compact.first
    @user = "Chris"
    @weight = session[:weight]
  end

  before /images/ do
    @message = "Jasper is pretty"
  end

  after do
    logger.info "<== Leaving request"
  end

  get '/images' do
    @images = JASPER
    erb :images, layout: true
  end

  get '/images/:index.?:format?' do |index, format|
    index = index.to_i
    @image = JASPER[index]

    if format == "jpg"
      content_type :jpg
      send_file "images/#{index}.jpg"
    else
      erb :"/images/show", layout: true
    end
  end

  get '/sessions/new' do
    erb :"/sessions/new", layout: true
  end

  post '/sessions' do
    session[:weight] = params[:weight]
    redirect '/images'
  end

  get '/' do
    erb :home, layout: true
  end

  post '/' do
    "Hello World via POST"
    params["wew"]
  end

  put '/' do
    "Jasper via PUT"
  end

  delete '/' do
    "Jasper via DELETE #{params['wew']}"
  end

  get '/:first_name/?:last_name?' do |first, last|
    "Hello #{first} #{last}"
  end


end
