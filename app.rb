require "rubygems"
require "bundler"

Bundler.require

require "sinatra/reloader"

set :database, adapter: "sqlite3", database: "media_search.sqlite3"

# modelの読み込み
require "./models/image.rb"
require "./services/extract_rgb.rb"

module MediaSearch
  class App < Sinatra::Base
    register Sinatra::FormKeeper

    get "/" do
      images = Image.all
      erb :index, layout: :layout, locals: { images: images }
    end

    get "/new" do
      erb :new
    end

    get "/search" do
      id = params[:image].to_i
      results = Image.sort_by_similar_rgb(id)
      images = Image.all

      erb :index, layout: :layout, locals: { images: images, results: results }
    end

    post "/create" do
      form do
        filters :strip
        field :title,   :present => true
        field :author, :present => true
        field :url, :present => true
      end
      if form.failed?
        output = erb :new
        fill_in_form(output)
      else
        red, green, blue = ExtractRgb.extract(form[:title], form[:url]).map { |i| i / 256.0 }

        Image.create(title: form[:title], author: form[:author], url: form[:url], red: red, green: green, blue: blue)

        redirect '/'
      end
    end
  end
end
