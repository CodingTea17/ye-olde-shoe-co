require("bundler/setup")
Bundler.require(:default)

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

get '/store/brands/:id' do
  @store = Store.find(params[:id])
  @brands = Brand.all
  erb :store_brands
end

######### This route lets a user add an existing brand #########
post '/store/brands/:id/add' do
  store = Store.find(params[:id])
  selected_brand = Brand.find(params["brand_id"])
  store.inventories.create({:store => store, :brand => selected_brand})
  redirect "/store/brands/#{store.id}"
end
################################################################

###### This route lets a user create and add a new brand #######
post '/store/brands/:id/create' do
  store = Store.find(params[:id])
  new_brand = Brand.new({:name => params["name"], :price => params["price"]})
  if new_brand.save
    store.inventories.create({:store => store, :brand => new_brand})
    redirect "/store/brands/#{store.id}"
  else

  end
end
################################################################

delete '/store/brands/:store_id/remove/:brand_id' do
  Inventory.where({:brand_id => params[:brand_id], :store_id => params[:store_id]}).first.delete
  redirect back
end

patch '/store/update/:id' do
  store = Store.find(params[:id])
  store.update({:name => params["name"]})
  redirect "/stores"
end

delete '/store/delete/:id' do
  store = Store.find(params[:id])
  store.destroy
  redirect '/stores'
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

delete '/brand/delete/:id' do
  brand = Brand.find(params[:id])
  brand.destroy
  redirect '/brands'
end
