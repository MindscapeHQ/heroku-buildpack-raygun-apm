# Heroku buildpack for Raygun APM

This buildpack installs the [Raygun APM](https://raygun.com/platform/apm) agent on your dyno, and starts it after every deploy. To collect data from a Ruby application, you also need the relevant Ruby gem ([raygun-apm-rails](https://rubygems.org/gems/raygun-apm-rails) for a Rails app, [raygun-apm](https://rubygems.org/gems/raygun-apm) otherwise) to your Gemfile.

## Installation

_If you've never deployed your Rails project on Heroku before, please consult [these instructions](https://devcenter.heroku.com/articles/getting-started-with-rails5) first to get started._

```
cd <YOUR RUBY/RAILS PROJECT>

# Initialize a new Heroku project
heroku create

# add the Ruby buildpack
heroku buildpacks:add heroku/ruby

# add this buildpack
heroku buildpacks:set https://github.com/MindscapeHQ/heroku-buildpack-raygun-apm

# add your APM API key to your application configuration
heroku config:add RAYGUN_API_KEY=<YOUR RAYGUN API KEY>

# Deploy to Heroku
git push heroku master
```

Once installed, the APM agent is started automatically when each dyno starts.

## Troubleshooting

### Your agent starts according to the Heroku build log, but no data is flowing through to the APM.

Make sure your Gemfile has the APM gem in it:

```
group :production do
  gem 'raygun-apm-rails'
end
```
