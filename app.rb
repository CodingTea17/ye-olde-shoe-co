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

get '/brands' do
  @brands = Brand.all
  erb :brand_index
end
