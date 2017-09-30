# _Ye Olde Shoe Co._

#### _This application allows a shoe distribution company to manage their products and customers, 9/29/2017_

#### By _**Dawson Mortenson**_

### This application provides the follow functionality ("user stories"):
⭐ As a user, I want to be able to add, update, delete and list shoe stores.
⭐ As a user, I want to be able to add and list new shoe brands. Shoe brands should include price.
⭐ As a user, I want to be able to add shoe brands in the application (don't worry about updating, listing or destroying shoe brands).
⭐ As a user, I want to be able to add existing shoe brands to a store to show where they are sold.
⭐ As a user, I want to be able to associate the same brand of shoes with multiple stores.
⭐ As a user, I want to be able to see all of the brands a store sells on the individual store page.
⭐ As a user, I want store names and shoe brands to be saved with a capital letter no matter how I enter them.
⭐ As a user, I want the price to be in currency format even if I just inputted a number. (In other words, typing in 50 should be updated to $50.00.)
⭐ As a user, I do not want stores and/or shoe brands to be saved if I enter a blank name.
⭐ As a user, I want all stores and brands to be unique. There shouldn't be two entries in the database for Blundstone.
⭐ As a user, I want store and brand names to have a maximum of one hundred characters.
⭐ Add styling and images to your site for an improved user experience.
⭐ Add user authentication (such as bcrypt, Devise or Sinatra's HTTP Authentication) so that only authorized users can create, update and delete stores and brands.

### Initial Database Schema
![Alt text](./public/db_schema_design.png?raw=true "Database Schema Design")

### Setup (Make sure you have a postgres server running)
1. Clone the project and cd into ye-olde-shoe-co
2. run `bundle`
3. run `rake db:create`
4. run `rake db:migrate`
5. run `rake db:test:prepare` to be able to run tests
6. Start up the app by running `ruby app.rb` :rocket:
7. Visit localhost:4567 in your favorite browser to use the application
8. The default user credentials are username: "admin", password: "isarubyist"
9. To run tests run rspec

### Support and contact details
_If you have any questions, concerns, or suggestions shoot me an email: dawson.mortenson@gmail.com_

### Technologies Used
_HTML, CSS, Bootstrap, Sinatra, Ruby, Postgres, :octocat:_

### License
*This website is licensed under the MIT License*

Copyright (c) 2017 **_Dawson Mortenson_**
