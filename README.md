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