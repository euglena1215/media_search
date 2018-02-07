require "rubygems"
require "bundler"

Bundler.require

require "sinatra/reloader"

set :database, adapter: "sqlite3", database: "media_search.sqlite3"

# modelの読み込み
require "./models/document.rb"

module MediaSearch
  class App < Sinatra::Base
    get "/" do
      documents = Document.all
      erb :index, layout: :layout, locals: { documents: documents }
    end

    get "/search" do
      results = Document.where('title like ? OR content like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%").order(page_rank: :desc)
      documents = Document.all

      erb :index, layout: :layout, locals: { documents: documents, results: results }
    end
  end
end
