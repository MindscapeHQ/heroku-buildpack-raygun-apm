# Heroku buildpack for Raygun APM

This buildpack installs the [Raygun APM](https://raygun.com/platform/apm) agent on your dyno, and starts it after every deploy. To collect data from your application, you will also need the relevant Raygun library for your language installed and loaded.

For more information see the language specific instructions below.

## Ruby/Rails

_If you've never deployed your Rails project on Heroku before, please consult [these instructions](https://devcenter.heroku.com/articles/getting-started-with-rails5) first to get started._

### Installation

For Ruby applications, you need to add the relevant Ruby gem ([raygun-apm-rails](https://rubygems.org/gems/raygun-apm-rails) for a Rails app, [raygun-apm](https://rubygems.org/gems/raygun-apm) otherwise) to your Gemfile.

```
cd <YOUR RUBY/RAILS PROJECT>

# Initialize a new Heroku project
heroku create

# add this buildpack
heroku buildpacks:set https://github.com/MindscapeHQ/heroku-buildpack-raygun-apm

# add the Ruby buildpack
heroku buildpacks:add heroku/ruby

# add your APM API key to your application configuration
heroku config:add RAYGUN_API_KEY=<YOUR RAYGUN API KEY>

# Deploy to Heroku
git push heroku master
```

Once installed, the APM agent is started automatically when each dyno starts.

### Troubleshooting

#### Your agent starts according to the Heroku build log, but no data is flowing through to the APM.

Make sure your Gemfile has the APM gem in it:

```
group :production do
  gem 'raygun-apm-rails'
end
```

## Node.js

_If you've never deployed a Node.js project on Heroku before, please consult [these instructions](https://devcenter.heroku.com/articles/getting-started-with-nodejs) first to get started._

### Installation

For Node applications, you will need to install and import the [raygun-apm](https://www.npmjs.com/package/raygun-apm) package.

Please consult the [`raygun-apm` documentation](https://www.npmjs.com/package/raygun-apm) for detailed instructions on installing and configuring. For simple web applications, this should be enough:

  * `npm install --save raygun-apm`
  * Add `require('raygun-apm/http')` or `import 'raygun-apm/http'` at the top of your app's entrypoint.


```
cd <YOUR NODE.JS PROJECT>

# Initialize a new Heroku project
heroku create

# add this buildpack
heroku buildpacks:set https://github.com/MindscapeHQ/heroku-buildpack-raygun-apm

# add the Ruby buildpack
heroku buildpacks:add heroku/nodejs

# add your APM API key to your application configuration
heroku config:add RAYGUN_API_KEY=<YOUR RAYGUN API KEY>

# Deploy to Heroku
git push heroku master
```

Once installed, the APM agent is started automatically when each dyno starts.

### Troubleshooting

#### Your agent starts according to the Heroku build log, but no data is flowing through to the APM.

Make sure your package.json contains the APM package:

```
  "dependencies": {
    "raygun-apm: "^0.4.0"
  }
```

The above version is an example. Please use the latest version available, which may not always be reflected in this README.

Also, the `raygun-apm` package needs to be imported before it can run. If you are writing a web app, please ensure that the first line of the entry point of your web server imports `raygun-apm/http`.
