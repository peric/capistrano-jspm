# Capistrano::Jspm[![Gem Version](https://badge.fury.io/rb/capistrano-jspm.svg)](https://badge.fury.io/rb/capistrano-jspm)

Jspm support for Capistrano 3.x

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano'
gem 'capistrano-jspm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-jspm

## Usage

Require in `Capfile` to use the default task:

```ruby
require 'capistrano/jspm'
```

The `jspm:install` task will run before `deploy:updated` as part of Capistrano's default deploy,
or can be run in isolation with `cap production jspm:install`

Configurable options, shown here with defaults:

```ruby
set :jspm_roles, :web
set :jspm_bin, :jspm
```

### jspm:bundle_sfx

`bundle_sfx` task is optional, and in order to run it on every deployment, add this to your `deploy.rb` file:

```ruby
before 'deploy:updated', 'jspm:bundle_sfx' do
  invoke 'jspm:bundle_sfx',
         'path/for/fromfile/app.js',
         'path/for/tofile/app.min.js'
end
```

Configurable options, shown here with defaults:

```ruby
set :jspm_sfx_flags, '--minify'
```
