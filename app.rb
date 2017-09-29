require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @stores = Store.all
  @brands = Brand.all
  erb :index
end

get '/stores' do
  @stores = Store.all
  erb :store_index
end

post '/store/new' do
  new_store = Store.new({:name => params["name"]})
  if new_store.save
    redirect '/stores'
  else

  end
end

get '/brands' do
  @brands = Brand.all
  erb :brand_index
end

post '/brand/new' do
  new_brand = Brand.new({:name => params["name"], :price => params["price"]})
  if new_brand.save
    redirect '/brands'
  else

  end
end
