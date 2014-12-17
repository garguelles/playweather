# Play Weather

## Status

[![Code Climate](https://codeclimate.com/github/rubycluster/playweather/badges/gpa.svg)](https://codeclimate.com/github/rubycluster/playweather)

## The Idea

Weather mood expressed in music.

## Screenshots

![screenshot-01](doc/screenshots/playweather-ss-01-a.jpg)

![screenshot-02](doc/screenshots/playweather-ss-02-a.jpg)

## How it works

* Visit [Play Weather](http://playweather.info/)
* Enter your location into the text field above
* ... or press the button with a globe icon to find your current geo location
* Press 'Play' button to request a weather forecast
* Listen to the music expressing the weather today
* Overview the weather for the next 5 days
* Share it with friends!

## Application Concept

* One-page application
* Responsive web design
* Cross-platform

## Application Tech Stack

### Engine

* [Marionette.js](http://marionettejs.com/)
* [Backbone.js](http://backbonejs.org/) and [Underscore.js](http://underscorejs.org/)
* [jQuery](http://jquery.com/) and jQuery plugins
* [Moment.js](http://momentjs.com)
* [Require.js](http://requirejs.org/)
* [Yeoman](http://yeoman.io/), [Grunt.js](http://gruntjs.com/), [Bower](http://bower.io/) as build tools
* [CoffeeScript](http://coffeescript.org/)
* [HAML](http://haml.info/) and [SASS](http://sass-lang.com/)
* [HTML5](http://en.wikipedia.org/wiki/HTML5) and [CSS3](http://www.w3schools.com/css3/)

### Design

* [GroundworkCSS](http://groundwork.sidereel.com/) grid framework
* [Font Awesome](http://fortawesome.github.io/Font-Awesome/) icons

# Used APIs

* [Jamendo API](http://developer.jamendo.com/v3.0)
* [Open Weather Map API](http://openweathermap.org/api)
* [Panoramio API](http://www.panoramio.com/api/)
* [Google Geocoding API](http://developers.google.com/maps/documentation/geocoding/)
* [HTML5 Geolocation API](http://www.w3schools.com/html/html5_geolocation.asp)

# Application Usage

## Requirements

* [Node.js](http://nodejs.org/)

## Install

    npm install -g yo grunt-cli bower
    git clone git://github.com/rubycluster/playweather.git
    cd playweather
    npm install
    bower install

## Configure

Copy example config files and add your own keys and values:

    cp app/scripts/config/settings/keys.coffee.example \
       app/scripts/config/settings/keys.coffee
    cp grunt-settings.json.example \
       grunt-settings.json

## Start development server

    grunt server --force

Application is now available at:

    http://localhost:9000/

## Build application

    grunt build

# License

The MIT License (MIT)

Copyright (c) 2013 [Vlad Alive](http://github.com/vladalive)

# Credits

[Developed](https://github.com/rubycluster/playweather) by [Vlad Alive](http://vladalive.com) at [Ruby Cluster](http://rubycluster.com) for [Jamendo Contest](http://developer.jamendo.com/contest)
