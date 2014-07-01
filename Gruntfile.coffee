module.exports = (grunt) ->
  grunt.initConfig
    uglify: 
      options:
        mangle:
          except: ['_', 'Backbone']
      dist:
        files:
          'js/backbone.chained.min.js': ['js/backbone-chained.js']
    coffee: 
      glob_to_multiple: 
        expand: true
        flatten: true
        src: [
          "backbone-chained.coffee"
          "examples/*.coffee"
        ]
        dest: 'js/'
        ext: '.js'

    watch:
      files: [
        "*.coffee",
        "examples/*.coffee"
        "Gruntfile.coffee"
      ]
      tasks: "coffee"

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
