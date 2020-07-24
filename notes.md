http://todomvc.com/examples/vanillajs/

Step 1: Integrate Basic Theme to Asset Pipeline

- Stubb out, non-dynamic, page with theme/ get rid of rails default page
    * Go to routes and create a site controller with a welcome action
    * Add the following: root 'site#index'
    * Visit localhost:3000 - will get error "uninitialized constant SiteController"
    * generate Site Controller - rails g controller site index 


Step 2: allow people to crud lists'
create 
see 
show

I want people to be able to create lists. Then they should be able to add items to those lists. They should be able to navigate many lists and see each lists items. 

lists
    has-many-items

items  
    belongs to a list


[List Controller]
 #index - see all their lists 
 doubling as my #new action in that it is presenting the person with the form to create a new list
 #index all the list
 create a list
 show a list 

 I need a model 
 I need a controller 

 generate a resource - both at once 

 rails generate resource list name


 That generated :
    invoke  active_record
      create    db/migrate/20200718235127_create_lists.rb
      create    app/models/list.rb
      invoke    test_unit
      create      test/models/list_test.rb
      create      test/fixtures/lists.yml
      invoke  controller
      create    app/controllers/lists_controller.rb
      invoke    erb
      create      app/views/lists
      invoke    test_unit
      create      test/controllers/lists_controller_test.rb
      invoke    helper
      create      app/helpers/lists_helper.rb
      invoke      test_unit
      invoke    assets
      invoke      scss
      create        app/assets/stylesheets/lists.scss
      invoke  resource_route
       route    resources :lists

    rails db:migrate

    Look into the console: 

    rails c

    List.create(:name => "FirstList")
    List.all

    update routes: root 'lists#index'

    rails destroy controller site 
    -- get rid of code once you realize you dont need it 
     
     Controller index == @lists = List.all

     Step 3 : Add an item to a list

     -   Make the items in a list real
      - a list has many items and every item belongs to a list.
      
      lists 

      items 
      id description list_id

      list_id is the foreign key which will equal to the lists id 

      since I dont know what I need - create the model generator.

      rails g model item description

        generates the following:
         invoke  active_record
      create    db/migrate/20200719021641_create_items.rb
      create    app/models/item.rb
      invoke    test_unit
      create      test/models/item_test.rb
      create      test/fixtures/items.yml

Then rails db:migrate and then set up your associations in the models.( belongs_to has_many relationship)

     -   CREATE AN ACTION for and ITEM in a list - WHat is the URL/ HTTP methos for that?

    Does it impact the db? - I probably need a items table - associated with a list.
    Does it impact my urls ?

Check your db with rails c
    - list.create(:description => "cookies")
    - list 
    - milk = Item.create
    - milk.description = "Milk"
    - milk
    - milk.list_id = list.id OR milk.list_id = list
    - milk.save
    - milk.list (belongs_to list create a method called list to )
    - Item.create(description: "cookies", list_id: 1)

    - list.items -- has_many allows this
    - list.items.create(:description => "new shoes")

    Make the items a real form for adding items
  
THe form is already present in the list show page.
What url does this imply?

Should be a post request
POST /items => Doesnt desctibe which list we are adding an item too

AN item doesnt exist in the application outside of the context of the list it belongs too

Nested resource

Post /lists/:id/items -> states that items are nested within this list - items are nrested int erms of urls under their parent list

Create a nested resource route in config/routes

rails g controller items create
 create  app/controllers/items_controller.rb
       route  get 'items/create'
      invoke  erb
      create    app/views/items
      create    app/views/items/create.html.erb
      invoke  test_unit
      create    test/controllers/items_controller_test.rb
      invoke  helper
      create    app/helpers/items_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/items.scss
    
Step 4 :

adding validations -- validate that items have a name and items have a description.

Step 5:
Add a state of complete/incomplete

What urls do I need and how might my db change?
- the idea of an item being complete or imcomplete require data. 
-new forms for updating the status of the item - which means new url 
/lists/1/itens 

PUT/PATCH lists/1/items/1
PUT/PATCH lists/:list_id/items/:id

I know I need to steal the checkbox HTML from todomvc.com 

add this to the view 
<input class="toggle" type="checkbox">

I need that Js function to submit the form when you click the checkbox (4.29)

$(function(){
    $("input.toggle").on("change", function(){
        $(this).parents("form").trigger("submit")
    })
});



<%# f.check_box :status, :class => "toggle", :checked => (true if item.complete?) %>

rake routes | grep items

Step 6 : Deleteing items from a list
- marking items as complete/incomplete


Update the schema:
rails generate migration AddStatusToItems status:integer

rake db:rollback

class AddStatusToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :status, :integer, :default => 0
  end
end

Create status methods inside of items model. 
    rails console
    l = List.first
    m = l.items.first
    m.complete?
         => false 
    m.incomplete?
        => true 
    m.status = 1
        => 1 
    m.save
    m.complete?
        => true 

<li class="<%= "completed" if item.complete? %>">
                        <div class="view">
                            <input class="toggle" type="checkbox" <%= "checked='checked'" if item.complete? %>>


Now you want to update the db based off the checkmark

REFACTOR 1: Start using a partial 

Delete an item from a list

I know i need a new delete button or link for the delete
that needs to hit come sort of URL - we can look that up
RESTful conventions
    How do we trigger a delete request - browsers only support get and post requst 

a controller action to process the delteing of the item

Next steps:

create users and follow these directions on new branch

rails g resource User name username password_digest 

rails generate migration AddUserToLists user_id:integer

SET UP MODELS & uncomment out bycrypt in gemfile 

m = User.new(name: "Sincerely", username: "brittany", password: "password")
m.save
true 

n = User.new(name: "steve", username: "brittany", password: "password")
n.save 
false (because of validations)
n.errors 
=> username already taken
n.username = "steve"
n.save

List.all

if you already have list 
a = List.first
a.user_id = n.id
a.save

b = List.find(2).user_id = m.id
b.save
c = List.find(3).user_id = m.id
c.save
d = List.find(4).user_id = n.id
d.save




If you have no list create a list and add a user 
P = List.create(name: "this is a list")


Create sign up: Always thing Route - M - V - C

Create new route: 
get "/signup" => "users#new", as: "signup"

So now your routes look like this:

  resources :users, except: [:new]
  get 'items/create'
  resources :lists do 
    resources :items
  end 
  get "/signup" => "users#new", as: "signup"
  root 'lists#index'

Create new user instance in controller

class UsersController < ApplicationController
    def new
        @user = User.new
    end 
end

Set up your signup view page:

<%= form_with model: @user, local: true do |f| %>
<%= f.text_field :name, placeholder: "name" %>
<%= f.text_field :name, placeholder: "username" %>
<%= f.password_field :name, placeholder: "password" %>
<%= f.submit %>
<% end %>

Now update your create method in user

   def create
        @user = User.new(user_params)
        if @user.save 
            session[:user_id] = @user.id #logs in the user -- tells app that user is logged in
            redirect_to lists_path
        else 
            render :new
        end 
    end

    Next in application view 

      <header>
  <%= navbar %>
  </header>

  create a helper 

   def navbar
        if logged_in?
            render "layouts/logged_in_navbar"
        else
            render "layouts/logged_out_navbar"
        end 
    end 

    update application controller:

      helper_method :logged_in?
      helper_method :current_user

    private

    def logged_in?
        !!current_user
    end 

    def current_user
        User.find_by(id: session[:user_id])
    end 

    Create the two layout partials 

    loggedin partial 
    <%= button_to 'Log Out', '/logout', method: :delete %>

    logged out partial

     <%= link_to 'Log In', login_path %>
  <%= link_to 'Sign Up', signup_path %>

  Update the routes 

  Rails.application.routes.draw do
  root 'lists#index'
  resources :users, except: [:new]

  get "/signup" => "users#new", as: "signup"
  get "/login" => "sessions#new", as: "login"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  get 'items/create'
  resources :lists do 
    resources :items
  end 
end


Create a sessions controller 

rails g controller sessions 

sessions/new view:

<%= form_tag("/login") do %>
<%= text_field_tag :username,nil, placeholder: 'username'%>
<%= password_field_tag :password, nil, placeholder: 'password' %>
<%= submit_tag "Login"%>
<% end %>


    sessions controller 
      def create 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            # session[:user_id]
            log_in(@user)
            flash[:sucess] = "Welcome, #{@user.username}"
            redirect_to lists_path
        else 
            flash[:danger] = "Improper credentials given"
            redirect_to login_path
        end 
    end

    application_controller
    def log_in(user)
        session[:user_id] = user.id
    end 

    def authenticate
        redirect_to login_path if !logged_in?
    end 

    application.html.erb

    <header>
  <% flash.each do |k,v| %>
    <%= v %>
    <% end %>
  <%= navbar %>
  </header>
    <%= yield %>
   
</html>






