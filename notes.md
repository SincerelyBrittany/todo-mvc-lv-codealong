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
    

Step whatever