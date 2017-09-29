require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @recipes = Recipe.where("rating >= 4").sample(3)
  @ingredients = Ingredient.all
  @tags = Tag.all
  erb :index
end

get '/recipe/:id' do
  @recipe = Recipe.find(params[:id])
  erb :recipe
end

post '/recipe/new' do
  name = params["name"]
  new_recipe = Recipe.new({:name => name})
  if new_recipe.save
    redirect "/recipe/new/#{new_recipe.id}/ingredient"
  else
    erb :error # Change to redirect route
  end
end

get '/recipe/new/:id/ingredient' do
  @recipe = Recipe.find(params[:id])
  @units = Unit.all
  @ingredients = Ingredient.all()
  erb :add_ingredient
end

# ADD an ingredient
post '/recipe/new/:id/ingredient/add' do
  # Grab data from form
  ingredient_id = params["ingredient_id"]
  quantity = params["quantity"]
  unit_id = params["unit_id"]
  # Find the recipe we are creating
  new_recipe = Recipe.find(params[:id])
  # Find the ingredient
  an_ingredient = Ingredient.find(ingredient_id)
  # Create an entry in List Table that associates our recipe with a given ingredient, quantity, and unit measurement
  new_recipe.lists.create(:ingredient => an_ingredient, :quantity => quantity, :unit_id => unit_id)
  # Puts us back on the add ingredient GET route so that we can add more ingredients
  redirect "/recipe/new/#{new_recipe.id}/ingredient"
end

# CREATE and ADD an ingredient
post '/recipe/new/:id/ingredient/create' do
  # Grab data from form
  ingredient_name = params["name"]
  quantity = params["quantity"]
  unit_id = params["unit_id"]
  # Find the recipe we are creating
  new_recipe = Recipe.find(params[:id])
  # Create a new ingredient
  new_ingredient = Ingredient.create({:name => ingredient_name})
  new_recipe.lists.create(:ingredient => new_ingredient, :quantity => quantity, :unit_id => unit_id)
  redirect "/recipe/new/#{new_recipe.id}/ingredient"
end

#In this route the user will add steps to their recipe
get '/recipe/new/:id/step' do
  @recipe = Recipe.find(params[:id])
  @steps = Step.all
  erb :create_step
end

#CREATE and ADD a step
post '/recipe/new/:id/step/create' do
  step = params["step"]
  new_recipe = Recipe.find(params[:id])
  new_step = Step.create({:name => step, :recipe_id => params[:id], :step_num => new_recipe.steps.count + 1})
  redirect "/recipe/new/#{new_recipe.id}/step"
end

post '/recipes/by_ingredient' do
  redirect "recipes/by_ingredient/#{params['id']}"
end

#View all recipes with a certain ingredient
get '/recipes/by_ingredient/:id' do
  ingredient = Ingredient.find(params[:id])
  @recipes = ingredient.recipes
  erb :results
end

get '/recipe/new/:id/tag' do
  @recipe = Recipe.find(params[:id])
  @tags = Tag.all
  erb :create_tag
end

# CREATE and ADD an ingredient
post '/recipe/new/:id/tag/create' do
  # Grab data from form
  name = params["name"]
  # Find the recipe we are creating
  our_recipe = Recipe.find(params[:id])
  # Create a new tag
  new_tag = Tag.create({:name => name})
  our_recipe.tags.push(new_tag)
  redirect "/recipe/new/#{our_recipe.id}/tag"
end

# ADD an ingredient
post '/recipe/new/:id/tag/add' do
  # Find the recipe we are creating
  our_recipe = Recipe.find(params[:id])
  # Create a new tag
  tag = Tag.find(params["tag_id"])
  our_recipe.tags.push(tag)
  redirect "/recipe/new/#{our_recipe.id}/tag"
end

post '/recipes/by_tag' do
  redirect "recipes/by_tag/#{params['tag_id']}"
end

get '/recipes/by_tag/:id' do
  tag = Tag.find(params[:id])
  @recipes = tag.recipes
  erb :results
end

patch '/recipe/new/:id/rating' do
  recipe = Recipe.find(params[:id])
  recipe.update({:rating => params["rating"]})
  redirect "/recipe/new/#{recipe.id}/tag"
end

delete '/recipe/:id/delete' do
  recipe = Recipe.find(params[:id])
  recipe.steps.each do |step|
    step.delete
  end
  recipe.destroy
  redirect '/'
end
