exports.config =
  # See docs at http://brunch.readthedocs.org/en/latest/config.html.

  # Application build path.  Default is public
  #buildPath: ''
  #
  conventions:
    ignored: [
      /bower_components\/angular/,
      'bower_components/ionic/release/js/ionic-angular.js'
    ]

  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^(bower_components|vendor)/
        'test/javascripts/test.js': /^test[\\/](?!vendor)/
        'test/javascripts/test-vendor.js': /^test[\\/](?=vendor)/
      order:
        before: [
          'bower_components/jquery/**/*',
          'bower_components/underscore/**/*',
          'bower_components/**/*',
          'vendor/scripts/console-helper.js',
          'vendor/scripts/backbone-mediator.js',
          'vendor/scripts/backbone.layoutmanager-0.7.5.js',
          'vendor/config/jqm-routing-patch.js',
          'vendor/config/jqm-hover-patch.js',
        ],
        after: [
          'vendor/scripts/bootstrap-editable.js',
          'vendor/scripts/bootstrap-notify.js',
          'vendor/config/backbone.syphon-config.js',
          'test/vendor/scripts/test-helper.js'
        ]

    stylesheets:
      defaultExtension: 'scss'
      joinTo: 
        'stylesheets/app.css': 'app/styles/app.scss'
        'stylesheets/vendor.css': /^vendor/
        'test/stylesheets/test.css': /^test/
      order:
        after: ['vendor/styles/helpers.css']

    templates:
      defaultExtension: 'hbs'
      joinTo: 'javascripts/templates.js'

  modules:
    definition: (path, data) ->
      """
      (function(/*! Brunch !*/) {
        'use strict';

        var globals = typeof window !== 'undefined' ? window : global;
        if (typeof globals.require === 'function') return;

        var modules = {};
        var cache = {};

        var has = function(object, name) {
          return ({}).hasOwnProperty.call(object, name);
        };

        var expand = function(root, name) {
          var results = [], parts, part;
          if (/^\\.\\.?(\\/|$)/.test(name)) {
            parts = [root, name].join('/').split('/');
          } else {
            parts = name.split('/');
          }
          for (var i = 0, length = parts.length; i < length; i++) {
            part = parts[i];
            if (part === '..') {
              results.pop();
            } else if (part !== '.' && part !== '') {
              results.push(part);
            }
          }
          return results.join('/');
        };

        var dirname = function(path) {
          return path.split('/').slice(0, -1).join('/');
        };

        var localRequire = function(path) {
          return function(name) {
            var dir = dirname(path);
            var absolute = expand(dir, name);
            return globals.require(absolute);
          };
        };

        var initModule = function(name, definition) {
          var module = {id: name, exports: {}};
          cache[name] = module;
          definition(module.exports, localRequire(name), module);
          return module.exports;
        };

        var require = function(name) {
          var path = expand(name, '.');

          if (has(cache, path)) return cache[path].exports;
          if (has(modules, path)) return initModule(path, modules[path]);

          var dirIndex = expand(path, './index');
          if (has(cache, dirIndex)) return cache[dirIndex].exports;
          if (has(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

          throw new Error('Cannot find module "' + name + '"');
        };

        var define = function(bundle, fn) {
          if (typeof bundle === 'object') {
            for (var key in bundle) {
              if (has(bundle, key)) {
                modules[key] = bundle[key];
              }
            }
          } else {
            modules[bundle] = fn;
          }
        };

        globals.require = require;
        globals.require.define = define;
        globals.require.register = define;
        globals.require.brunch = true;
      })();

    """

  minify: no
