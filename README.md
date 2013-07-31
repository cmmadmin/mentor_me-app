# Mentor Me Mobile App

Main languages are CoffeeScript,
[Stylus for CSS pre-processing](http://learnboost.github.com/stylus/) and
[Handlebars for templating](http://handlebarsjs.com/). 

Main JS framework is [Backbone.js](http://www.backbonejs.org)

Application assembler is [Brunch](http://brunch.io)

## Installation

First install [Node.js](http://nodejs.org) and NPM(node package manager). 

To install all the application dependencies run `npm install` in the project root directory. 
This will download all the packages to a folder node_modules in your project root.

To "assemble" the application once run `brunch build`. To continually watch for changes, use `brunch watch`. This will assemble/compile the project into the `public/` directory. 
This directory will contain all the necessary javascript, css, and html to run the application.

To actually run and view the application you can serve the `public/` directory as a static folder using your preferred webserver. 
I use [Pow](http://pow.cx) which is a great zero-configuration rack server which can also be used to map a dev url `mentormeapp.dev` to a static rack server included in `server.js`

Alternatively, you can also run `brunch watch --server` which will startup a basic webserver to serve your project to the browser. Look at the [Brunch](http://brunch.io) docs for more information.

## Overview

    config.coffee
    README.md
    /app/
      /assets/
        index.html
        images/
      styles/
      helpers/
      collections/
      config/
        ApplicationConfig.coffee <---- Application-wide settings including SERVER URL to pull data from
      events/
      utils/
      models/
      routers/
      styles/
      templates/
      views/

      MentorMe.coffee <---- Main Marionette.Application
      initialize.coffee
    /test/
    /vendor/
      scripts/
        backbone.js
        jquery.js
        console-helper.js
        underscore.js
      styles/
        normalize.css
        helpers.css

* `config.coffee` contains configuration of your app. You can set plugins /
languages that would be used here. Also the build order of the coffeescript files is defined here
* `app/assets` contains images / static files. Contents of the directory would
be copied to `public/` without change.
Other `app/` directories could contain files that would be compiled. Languages,
that compile to JS (coffeescript, roy etc.) or js files and located in app are 
automatically wrapped in a Require.js module closure so they can be loaded by 
`require('module/location')`.
* `app/[models,collections,controllers,models,routers,views]` contain the majority of the application code composed of Backbone and Marionette models, controllers, views, etc. Read [Backbone.js](http://backbonejs.org) and [Marionette.js](http://marionettejs.com) documentation for more info.
* `app/styles` contains Stylus and Sass templates that are compiled to CSS.
* `test/` contains feature & unit tests.
* `vendor/` contains all third-party code. The code wouldn’t be wrapped in
modules, it would be loaded instantly instead.

This all will generate `public/` (by default) directory when `brunch build` or `brunch watch` is executed.

## Other
Versions of software the skeleton uses:

* jQuery 1.8.3
* Backbone 1.0.0
* Backbone.Marionette 1.0.0-rc6
* Underscore 1.5.1
