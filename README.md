# DEMO

# Prerequisite

- `ruby` 3.2.2
- `node` 18.x

# Local Development

```sh
# setup the DB
rails db:create
rails db:migrate

# start the server
foreman start
```

# Steps

## Create a project

```sh
rails new my-rails-app --database=postgresql --javascript=esbuild --css=bootstrap
```

## Install Devise

https://github.com/heartcombo/devise#getting-started

## Install Doorkeeper

https://doorkeeper.gitbook.io/guides/ruby-on-rails/getting-started

## Create the API engine

```sh
rails plugin new vendor/engines/api --database=postgresql --mountable --api
```

## Mount the created engine in the route

```sh
# Add to config/routes.rb

mount Api::Engine, at: "api"

```

## Install gem doorkeeper-jwt

```sh
bundle add doorkeeper-jwt
```

## API engine doorkeeper and doorkeeper-jwt setup 

Look at `vendor/engines/api/config/initializers/doorkeeper.rb`
