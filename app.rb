require "rubygems"
require "bundler"

Bundler.require

set :database, adapter: "sqlite3", database: "media_search.sqlite3"

# modelの読み込み
require "./models/image.rb"

get "/" do
  images = Image.all
  erb :index, locals: { images: images }
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

  erb :index, locals: { images: images, results: results }
end
