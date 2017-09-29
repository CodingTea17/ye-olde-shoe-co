require("bundler/setup")
Bundler.require(:default)
enable :sessions

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

admin = User.new(:username => "admin", :pass => "isarubyist")
admin.save

helpers do
  def current_user
    if session[:user_id]
       User.find { |u| u.id == session[:user_id] }
    else
      nil
    end
  end
end

get '/' do
  @stores = Store.all
  @brands = Brand.all
  erb :index
end

get '/sign_in' do
  erb :sign_in
end

post '/sign_in' do
  user = User.find { |u| u.username == params["username"] }
  if user && user.auth_pass(params["pass"], user.pass)
    session.clear
    session[:user_id] = user.id
    redirect '/'
  else
    @error = 'Username or password was incorrect'
    erb :sign_in
  end
end

get '/sign_out' do
  session.clear
  redirect back
end


get '/stores' do
  if current_user
    @stores = Store.all
    erb :store_index
  else
    redirect '/sign_in'
  end
end

post '/store/new' do
  if current_user
    @new_store = Store.new({:name => params["name"]})
    if @new_store.save
      redirect '/stores'
    else
      @stores = Store.all
      erb :store_index
    end
  else
    redirect '/sign_in'
  end
end

get '/store/brands/:id' do
  if current_user
    @store = Store.find(params[:id])
    @brands = Brand.all
    erb :store_brands
  else
    redirect '/sign_in'
  end
end

######### This route lets a user add an existing brand #########
post '/store/brands/:id/add' do
  if current_user
    store = Store.find(params[:id])
    selected_brand = Brand.find(params["brand_id"])
    store.inventories.create({:store => store, :brand => selected_brand})
    redirect "/store/brands/#{store.id}"
  else
    redirect '/sign_in'
  end
end
################################################################

###### This route lets a user create and add a new brand #######
post '/store/brands/:id/create' do
  if current_user
    store = Store.find(params[:id])
    new_brand = Brand.new({:name => params["name"], :price => params["price"]})
    if new_brand.save
      store.inventories.create({:store => store, :brand => new_brand})
      redirect "/store/brands/#{store.id}"
    else

    end
  else
    redirect '/sign_in'
  end
end
################################################################

delete '/store/brands/:store_id/remove/:brand_id' do
  if current_user
    Inventory.where({:brand_id => params[:brand_id], :store_id => params[:store_id]}).first.delete
    redirect back
  else
    redirect '/sign_in'
  end
end

get '/store/update/:id' do
  if current_user
    @store = Store.find(params[:id])
    erb :store_update
  else
    redirect '/sign_in'
  end
end

patch '/store/update/:id' do
  if current_user
    store = Store.find(params[:id])
    store.update({:name => params["name"]})
    redirect "/stores"
  else
    redirect '/sign_in'
  end
end

delete '/store/delete/:id' do
  if current_user
    store = Store.find(params[:id])
    store.destroy
    redirect '/stores'
  else
    redirect '/sign_in'
  end
end

get '/brands' do
  if current_user
    @brands = Brand.all
    erb :brand_index
  else
    redirect '/sign_in'
  end
end

post '/brand/new' do
  if current_user
    @new_brand = Brand.new({:name => params["name"], :price => params["price"]})
    if @new_brand.save
      redirect '/brands'
    else
      @brands = Brand.all
      erb :brand_index
    end
  else
    redirect '/sign_in'
  end
end

delete '/brand/delete/:id' do
  if current_user
    brand = Brand.find(params[:id])
    brand.destroy
    redirect '/brands'
  else
    redirect '/sign_in'
  end
end

get '/brand/stores/:id' do
  if current_user
    @brand = Brand.find(params[:id])
    erb :brand_stores
  else
    redirect '/sign_in'
  end
end
