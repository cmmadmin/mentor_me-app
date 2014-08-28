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
          'app/MentorMe.coffee',
          /^app\/lib\/entities/,
          /^app\/lib\/concerns/,
          /^app\/lib\/utilities/,
          /^app\/lib\/(controllers|views)/,
          /^app\/lib/,
          'app/config/*', # include config before everything
          'app/*/supers/*', # include base classes in 'super' directory before the rest
          'app/models/UserSession.coffee'
          'app/views/**/*', # include views before controllers
          'app/controllers/SnapshotController.coffee',
          'app/models/state_machines/*',
          'app/models/**/*',
          'app/entities/**/*'
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

  plugins:
    handlebars:
      namespace: 'JST'
      pathReplace: /^.*app\//
    coffeescript:
      bare: false

  modules:
    wrapper: false
    definition: false

  minify: no
