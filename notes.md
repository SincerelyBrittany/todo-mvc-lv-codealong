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

