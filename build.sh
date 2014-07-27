#!/bin/sh

cp app/config/ApplicationConfig.coffee.example app/config/ApplicationConfig.coffee
./node_modules/bower/bin/bower install
./node_modules/.bin/brunch build