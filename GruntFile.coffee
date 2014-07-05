require "fs"

module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask "initGallery", ->
    fs.readdir '360images', (err, files) ->
      return if err
      for dir in dirs


  grunt.initConfig

    # watch:
      # coffee:
        # files: 'coffee/*.coffee'
        # tasks: ['coffee:compile']
#
    # coffee:
      # compile:
        # expand: true,
        # flatten: true
        # src: ['coffee/*.coffee']
        # dest: 'js/',
        # ext: '.js'