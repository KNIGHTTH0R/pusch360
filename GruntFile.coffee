require "fs"

module.exports = (grunt) ->
  grunt.initConfig
    bowercopy:
      libs:
        options:
          destPrefix: "./lib"
        files:
          "jquery.js": "jquery/dist/jquery.js"
          "require.js": "requirejs/require.js"
          "jquery.ui.js": "jquery-ui/ui/jquery-ui.js"
          "almond.js": "almond/almond.js"
          "underscore.js": "underscore-amd/underscore.js"
          "backbone.js": "backbone-amd/backbone.js"
          "text.js": 'requirejs-text/text.js'
          "cs.js": 'require-cs/cs.js'
          "coffee-script.js": 'coffee-script/index.js'
          "require-less": 'require-less'

    requirejs:
      frontend:
        options:
          wrap: true
          waitSeconds : 0,
          baseUrl : './lib',
          name : './almond',
          include: ['app'],
          insertRequire: ['app'],
          mainConfigFile : ['config.js'],
          out : 'build.min.js',
          optimize : 'none',
          # optimize : 'uglify2',
          generateSourceMaps : false
          preserveLicenseComments : false
          inlineText : true

  grunt.registerTask "initGallery", ->
    fs.readdir '360images', (err, files) ->
      return if err
      for dir in dirs then console.log("dir: ",dir)

  grunt.registerTask 'build', 'Compiles all of the assets and copies the files to the build directory.', [
    #'clean:build'
    'requirejs'
  ]


  require('load-grunt-tasks')(grunt)
