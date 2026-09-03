# Joppa Rails API

This repository is the Rails API for the Joppa application.

The project is intended to run in a standard local Linux development environment, using WSL2 on Windows when needed. It is not tied to AWS Cloud9, and Cloud9 should not be used as the long-term development platform.

## Quick start

If you are setting up this project for the first time on a Windows machine, the simplest path is:

```bash
# in Ubuntu/WSL
sudo apt update
sudo apt install -y build-essential curl git libssl-dev libyaml-dev libreadline-dev zlib1g-dev libpq-dev postgresql postgresql-contrib

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

rbenv install 3.1.2
rbenv global 3.1.2

gem install bundler

sudo service postgresql start
sudo -u postgres psql
```

Then inside PostgreSQL:

```sql
CREATE USER joppa WITH PASSWORD 'joppa';
ALTER USER joppa WITH SUPERUSER;
CREATE DATABASE workspace_development OWNER joppa;
CREATE DATABASE workspace_test OWNER joppa;
\q
```

Then in the app directory:

```bash
cd ~/JoppaRailsAPI
bundle install
rails db:setup
rails server -b 0.0.0.0 -p 3000
```

The API should start successfully on:

```text
http://localhost:3000
```

## Requirements

- Ruby 3.1.2
- Rails 6.1.4.7
- PostgreSQL 14+
- Node 18.10.0 for the Angular frontend if you are running the full app locally
- Git

## Recommended developer setup

Use WSL2 with Ubuntu 22.04 on Windows. This is the most reliable setup for Ruby and Postgres on a Windows machine.

### 1) Install system dependencies

```bash
sudo apt update
sudo apt install -y build-essential curl git libssl-dev libyaml-dev libreadline-dev zlib1g-dev libpq-dev postgresql postgresql-contrib
```

### 2) Install rbenv and Ruby 3.1.2

```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

rbenv install 3.1.2
rbenv global 3.1.2
ruby -v
```

The project is pinned to Ruby 3.1.2 in the Gemfile and should be run with that version.

### 3) Install Bundler

```bash
gem install bundler
bundle -v
```

## PostgreSQL setup

Start PostgreSQL:

```bash
sudo service postgresql start
```

Create the local database user and databases:

```bash
sudo -u postgres psql
```

Then run:

```sql
CREATE USER joppa WITH PASSWORD 'joppa';
ALTER USER joppa WITH SUPERUSER;
CREATE DATABASE workspace_development OWNER joppa;
CREATE DATABASE workspace_test OWNER joppa;
\q
```

## Local app configuration

The app uses PostgreSQL with explicit credentials for development and test. Make sure the config file matches the following settings:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  template: template0
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: workspace_development
  username: joppa
  password: joppa
  host: localhost

test:
  <<: *default
  database: workspace_test
  username: joppa
  password: joppa
  host: localhost

production:
  <<: *default
  database: workspace_production
  username: workspace
  password: <%= ENV['WORKSPACE_DATABASE_PASSWORD'] %>
```

If PostgreSQL is configured with peer authentication for local Unix socket connections, Rails may fail unless you use `host: localhost` and password authentication. This is the most reliable local setup for development.

## Install app dependencies

From the project root:

```bash
cd ~/JoppaRailsAPI
bundle install
```

Set up the database:

```bash
rails db:setup
```

If needed:

```bash
rails db:create
rails db:migrate
rails db:seed
```

## Run the Rails API locally

```bash
rails server -b 0.0.0.0 -p 3000
```

The API will be available at:

```text
http://localhost:3000
```

## Angular frontend local testing

The Angular frontend expects the API at the local Rails server when developing locally.

In the frontend app, update the development environment to:

```ts
export const environment = {
  production: false,
  api_url: 'http://localhost:3000/'
};
```

Then start the UI locally:

```bash
cd ~/JoppaTest
npm install
npm run devStart
```

This typically starts the Angular app on:

```text
http://localhost:4200
```

## Heroku setup

The project historically used Heroku for both test and production deploys.

Install the Heroku CLI in WSL if you need to manage Heroku deployments or run migrations:

```bash
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
heroku --version
heroku login
```

Add the remotes:

```bash
git remote add testheroku https://git.heroku.com/joppa-api-test.git
git remote add heroku https://git.heroku.com/joppa-api-prod.git
```

Check remotes:

```bash
git remote -v
```

Deploy to test:

```bash
git push testheroku main
```

Deploy to production:

```bash
git push heroku main
```

Run migrations:

```bash
heroku run rails db:migrate --app joppa-api-test
heroku run rails db:migrate --app joppa-api-prod
```

## Useful commands

```bash
rails routes
rails console
bundle install
spring stop
```

## Notes

- Cloud9 is deprecated and should not be used for ongoing development.
- WSL2 + Ubuntu is the preferred local setup for this project.
- The app should be developed against the Ruby version pinned in the Gemfile, not necessarily the latest Ruby version available.
- The Heroku CLI is useful when managing deploys, migrations, and remote app config, but local development should still happen in WSL with a local Rails API and local PostgreSQL.
