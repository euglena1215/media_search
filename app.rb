require "rubygems"
require "bundler"

Bundler.require

require "sinatra/reloader"

set :database, adapter: "sqlite3", database: "media_search.sqlite3"

# modelの読み込み
require "./models/image.rb"
require "./services/label.rb"

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

    get "/search_keyword" do
      results = Image.sort_by_keyword(params[:keyword])

      erb :index, layout: :layout, locals: { images: Image.all, results: results }
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
        labels, scores = Label.detect_labels(form[:url])

        Image.create(title: form[:title], author: form[:author], url: form[:url], labels: labels.join("/"), scores: scores.join("/"))

        redirect '/'
      end
    end
  end
end
