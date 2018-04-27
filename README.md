# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
* 

*HEROKU STUFF
* git add .
* git commit -m "the message"
* git push heroku master
* heroku run rails db:migrate
* heroku pg:reset   to reset pg database
* 
* to restart the database fresh, do heroku run rails db:migrate:reset

* to test in the terminal, then open new terminal window and make curl commands from users_controller.rb
* rails server -b $IP -p $PORT
* 


* GIT COMMANDS
* git fetch                         // gets list of existing branches
* git checkout myBranch             // if branch already made
* 

*git checkout -b newBranchName       // creates a new branch with this name based on the current code you see
*git add .                           // adds all of your changes
*git commit -m "the message"         // gets your changes ready to push
*git push origin newBranchName       // pushes your changes to this new branch on git
*git checkout master                // checkout master
*git pull origin master             // pull latest from master
*git merge test                     // merge test into this locally
*git push origin master             // push this merge to the git master

*git push heroku master             // pushes this current code to heroku master (deploys it)

* THIS NEXT COMMAND IS FOR GENERATING A DB TABLE, NEW ROUTES FOR THIS CONTROLLER, AND CRUD ENDPOINTS
* rails generate scaffold User username:string email:string age:integer weight:decimal is_active:boolean

*LOCALLY NEED TO DO THIS TO START UP THE DB TO RUN MIGRATIONS
*sudo service postgresql start
* rails db:create // only needs run once, maybe already done?
* 

* NEXT COMMAND STARTS UP THE LOCAL SERVER TO TEST THE ENDPOINTS, AND THEN A COMMAND TO POST.
* TO TEST A GET, DO SAME TYPE OF COMMAND EXCEPT REMOVE -d '{OBJECT}' PART
* rails rake routes // this command will display all of the routes your controller has to see if you made them right
*new terminal rails server -b $IP -p $PORT
* new terminal do curl -H "Content-Type:application/json; charset=utf-8" -d '{ "user" : { "username" : "testusername", "email" : "email@gmail.com", "password" : "password", "session_token" : "aslerkjaslelrkser" } }' https://hunting-log-api-kevinlewis2.c9users.io/users
* curl -H "Content-Type:application/json; charset=utf-8" https://hunting-log-api-kevinlewis2.c9users.io/users