# DEMO

# Prerequisite

- `ruby` 3.2.2
- `node` 18.x

# Local Development

```sh
# setup the DB
rails db:create
rails db:migrate

# !IMPORTANT! setup .env.development file according to .env.template

# start the server
bin/dev
```

# Steps

## Create a project

```sh
rails new my-rails-app --database=postgresql --javascript=esbuild --css=bootstrap
```

## Install Devise

https://github.com/heartcombo/devise#getting-started

```shell
bundle add devise
rails generate devise:install
```

Add to `config/environments/development.rb`
`config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }`

```shell
rails generate devise User
rails db:migrate
```

Add to `app/controllers/application_controllers.rb` 
`before_action :authenticate_user!`

## Install Doorkeeper

https://doorkeeper.gitbook.io/guides/ruby-on-rails/getting-started

```shell
bundle add doorkeeper
bundle exec rails generate doorkeeper:install
bundle exec rails generate doorkeeper:migration
```

### Integrating with existing User Model

Uncomment below to ensure a valid reference to the resource owner's table
At db/migrate/_create_doorkeeper_tables.rb

```ruby
add_foreign_key :oauth_access_grants, :users, column: :resource_owner_id
add_foreign_key :oauth_access_tokens, :users, column: :resource_owner_id
```

```shell
bundle exec rake db:migrate
```

Add to `app/models/user.rb`

```ruby
has_many :access_grants,
         class_name: 'Doorkeeper::AccessGrant',
         foreign_key: :resource_owner_id,
         dependent: :delete_all # or :destroy if you need callbacks

has_many :access_tokens,
         class_name: 'Doorkeeper::AccessToken',
         foreign_key: :resource_owner_id,
         dependent: :delete_all # or :destroy if you need callbacks
```

```ruby
# config/initializers/doorkeeper.rb
Doorkeeper.configure do
  resource_owner_authenticator do
    current_user || warden.authenticate!(scope: :user)
  end
end
```

## Create the API engine

```sh
rails plugin new vendor/engines/api --database=postgresql --mountable --api
```

```shell
# Make the created engine become mono repo
mv -f vendor/engines/api vendor/engines/api2 && mv -f vendor/engines/api2 vendor/engines/api
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

Look at `config/initializers/doorkeeper.rb` and `vendor/engines/api/config/initializers/doorkeeper.rb`

## Realtime-data

### Default Rails ActionCable

Add `broadcasts` to `app/models/post.rb`

Look at `app/views/posts/index.html.erb` and `app/views/posts/_post.html.erb`

Then try to play around with CRUD actions for `Post` model

### Use `anycable` as an adapter

Follow steps from the `Default Rails ActionCable` section first

https://docs.anycable.io/rails/getting_started

```shell
bundle add "anycable-rails"
bundle add "anycable-rails-jwt" 
bundle add "dotenv-rails"
bundle exec rails g anycable:setup
```

Look at `config/cable.yml` and `config/anycable.yml`

At `config/environments/development.rb` and `config/environments/production.rb`

Look at `config.action_cable.url` and `config.turbo.signed_stream_verifier_key` config

### Custom channels and use `anycable-rails-jwt` for identifiers

Comment out `AnyCable::Rails::Rack.middleware.use` in `config/initializers/anycable.rb`

For the server, look at `app/channels/application_cable/connection.rb` and `app/channels/dummy_channel.rb`

For the client, look at `app/javascript/controllers/hello_controller.js`

Add to a page you want to test
```html
<div data-controller="hello"></div>
```

Try to run `ActionCable.server.broadcast "dummy", {test: "data from dummy channel"}` in the console

You should see this message in the console `[ActionCable] Broadcasting to dummy: {:test=>"data from dummy channell"}`

# Test if everything work together 

```shell
# start the server
bin/dev
```

```shell
# TODO 
curl http://localhost:3000 \
   -H "Content-Type: application/json"
```
