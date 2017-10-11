require "rubygems"
require "bundler"

Bundler.require

set :database, adapter: "sqlite3", database: "media_search.sqlite3"

# modelの読み込み
require "./models/image.rb"

get "/" do
  "Hello World"
end
