Step 1: Integrate Basic Theme to Asset Pipeline

- Stubb out, non-dynamic, page with theme/ get rid of rails default page
    * Go to routes and create a site controller with a welcome action
    * Add the following: root 'site#welcome'
    * Visit localhost:3000 - will get error "uninitialized constant SiteController"
    * generate Site Controller 


Step 2: allow people to crud lists'
create 
see 
show

I want people to be able to create lists. Then they should be able to add items to those lists. They should be able to navigate many lists and see each lists items. 

lists
    has-many-items

items  
    belongs to a list