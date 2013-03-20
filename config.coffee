exports.config =
  # See docs at http://brunch.readthedocs.org/en/latest/config.html.

  # Application build path.  Default is public
  #buildPath: ''

  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^vendor/
        'test/javascripts/test.js': /^test[\\/](?!vendor)/
        'test/javascripts/test-vendor.js': /^test[\\/](?=vendor)/
      order:
        before: [
          'vendor/scripts/console-helper.js',
          'vendor/scripts/jquery-1.8.3.js',
          'vendor/scripts/underscore-1.4.3.js',
          'vendor/scripts/backbone-0.9.9.js',
          'vendor/scripts/backbone-mediator.js',
          'vendor/scripts/backbone.layoutmanager-0.7.5.js',
          'vendor/config/jqm-routing-patch.js',
          'vendor/config/jqm-hover-patch.js',
          'vendor/scripts/jquery.mobile-1.2.0.js'
        ],
        after: [
          'vendor/scripts/bootstrap-editable.js',
          'vendor/scripts/bootstrap-notify.js',
          'vendor/config/rivets-config.js',
          'test/vendor/scripts/test-helper.js'
        ]

    stylesheets:
      defaultExtension: 'styl'
      joinTo: 
        'stylesheets/app.css': /^(app|vendor)/
        'test/stylesheets/test.css': /^test/
      order:
        before: ['vendor/styles/normalize.css']
        after: ['vendor/styles/helpers.css']

    templates:
      defaultExtension: 'hbs'
      joinTo: 'javascripts/templates.js'

  minify: no
