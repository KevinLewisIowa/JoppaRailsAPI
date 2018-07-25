# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies
* 
* Installing yarn to grab and install dependencies in VS Code as listed in package.json file
* npm install yarn -g
* yarn --ignore-engines
* yarn devStart
*
* Installing postgresql and configuring for environment
* https://medium.com/@floodfx/setting-up-postgres-on-cloud9-ide-720e5b879154

* Configuration

* Database creation
* 
* LOCALLY NEED TO DO THIS TO START UP THE DB TO RUN MIGRATIONS
* sudo service postgresql start
* rails db:create // only needs run once, maybe already done?
* rails generate migration MigrationName    // create migration file to modify database schema
* rake db:migrate                           // apply migration changes to schema.rb
* 
* THIS NEXT COMMAND IS FOR GENERATING A DB TABLE, NEW ROUTES FOR THIS CONTROLLER, AND CRUD ENDPOINTS
* rails generate scaffold [TableName] [ListOfProperties:type] (ie username:string email:string age:integer weight:decimal is_active:boolean)
* 
* Database initialization
* 
* rails db:setup                            // create tables and seed data
* rails db:seed                             // add seed data from seeds.rb

* How to run the test suite
*  
* Using new terminal:
* NEXT COMMAND STARTS UP THE LOCAL SERVER TO TEST THE ENDPOINTS, AND THEN A COMMAND TO POST.
* TO TEST A GET, DO SAME TYPE OF COMMAND EXCEPT REMOVE -d '{OBJECT}' PART
* rails routes                              // this command will display all of the routes your controller has to see if you made them right
* rake routes                               // this command will display all of the routes your controller has to see if you made them right
* rails server -b $IP -p $PORT  // fires up server with designated IP and Port, of which $IP and $PORT are valid; use new terminal so that server can run in that terminal
* Command to test API call with data post:
* curl -H "Content-Type:application/json; charset=utf-8" -d '{ "user" : { "username" : "testusername", "email" : "email@gmail.com", "password" : "password", "session_token" : "aslerkjaslelrkser" } }' [preview URL]/[API method]
* Command to test API GET call (without data):
* curl -H "Content-Type:application/json; charset=utf-8" [Preview URL]/[API call]
* 
* Through Cloud9 screen:
* Preview, which will bring up browser window that you can test API in

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
* 

*HEROKU STUFF
* git add .
* git commit -m "the message"
* git push heroku master
* heroku run rails db:migrate
* heroku pg:reset                   // reset pg database
* 
* to restart the database fresh, do heroku run rails db:migrate:reset

* to test in the terminal, then open new terminal window and make curl commands from users_controller.rb
* rails server -b $IP -p $PORT
* 


* GIT COMMANDS
* 
* git branch                        // gets list of existing branches
* git checkout myBranch             // if branch already made
* git checkout -b newBranchName     // creates a new branch with this name based on the current code you see
* git diff                          // shows uncommitted changes from current branch
* git add .                         // adds all of your changes
* git commit -m "the message"       // gets your changes ready to push
* git push origin newBranchName     // pushes your changes to this new branch on git
* git checkout master               // checkout master
* git pull origin master            // pull latest from master
* git merge [branchName]            // merge test into this locally
* git push origin master            // push this merge to the git master

* git push heroku master            // pushes this current code to heroku master (deploys it)
