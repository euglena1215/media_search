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
  keyword = params[:keyword]

  results = Image.where(<<~"QUERY"
      (id LIKE "%#{keyword}%")
      OR (title LIKE "%#{keyword}%")
      OR (author LIKE "%#{keyword}%")
      OR (url LIKE "%#{keyword}%")
    QUERY
  )

  images = Image.all

  erb :index, locals: { images: images, results: results }
end