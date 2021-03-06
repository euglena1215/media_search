require "rubygems"
require "bundler"

Bundler.require

require "sinatra/reloader"

set :database, adapter: "sqlite3", database: "media_search.sqlite3"

# modelの読み込み
require "./models/image.rb"

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

    post "/search" do
      results = if params[:all].empty?
                  id = params[:id]
                  title = params[:title]
                  author = params[:author]
                  url = params[:url]
                  mode = params[:mode]

                  Image.partial_search(id: id, title: title, author: author, url: url, mode: mode)
                else
                  keyword = params[:all]
                  Image.all_search(keyword)
                end

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
        Image.create(title: form[:title], author: form[:author], url: form[:url])

        redirect '/'
      end
    end
  end
end
