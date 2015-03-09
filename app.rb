require "sinatra"
require "byebug"
require "awesome_print"


JASPER = [
  { title: "boxes", url: "https://igcdn-photos-h-a.akamaihd.net/hphotos-ak-xaf1/t51.2885-15/11005233_1387122404937847_746701829_n.jpg" },
  { title: "mint", url: "https://igcdn-photos-h-a.akamaihd.net/hphotos-ak-xaf1/t51.2885-15/11005122_403944089779711_82071826_n.jpg" },
  { title: "sun", url: "https://igcdn-photos-e-a.akamaihd.net/hphotos-ak-xaf1/t51.2885-15/10983603_463941597092988_1681238831_n.jpg" },
]

class App < Sinatra::Base

  get '/images' do
    @images = JASPER
    erb :images, layout: true
  end

  get '/images/:index' do |index|
    index = index.to_i
    @image = JASPER[index]
    erb :"/images/show", layout: true
  end

  get '/' do
    "Hello World"
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
