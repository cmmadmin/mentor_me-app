#!/bin/sh

cp app/config/ApplicationConfig.coffee.example app/config/ApplicationConfig.coffee
bower install
brunch build