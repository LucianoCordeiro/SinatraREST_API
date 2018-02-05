require 'sinatra'
require 'sinatra/json'
require 'bundler'

Bundler.require

require_relative 'cat'

DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.finalize
DataMapper.auto_migrate!

get '/' do
  @title = 'Home page'
  haml :home
  @cats = %w[Mario Anderson].join(', ')
end

get '/cats' do
  content_type :json

  cats = Cat.all
  cats.to_json
end

get '/cats/:id' do
  content_type :json

  cat = Cat.get(params[:id])
  cat.to_json
end

post '/cats' do
  content_type :json
  cat = Cat.new(params[:cat])
  if cat.save
    status 201
  else
    status 500
    json cat.errors.full_messages
  end
end

put '/cats/:id' do
  cat = Cat.get(params[:id])
  if cat.update(params[:cat])
    status 200
    json 'Cat has been updated'
  else
    status 500
    json review.errors.full_messages
  end
end

delete '/cats/:id' do
  cat = Cat.get(params[:id])
  if cat.destroy
    status 200
    json 'Cat has been deleted'
  end
end
