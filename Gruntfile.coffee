module.exports = (grunt) ->
  grunt.initConfig
    uglify: 
      options:
        mangle:
          except: ['_', 'Backbone']
      dist:
        files:
          'backbone.chained.min.js': ['backbone.chained.js']
    coffee: 
      compileWithMaps:
        options:
          sourceMap: true
        files:
          'backbone.chained.js': 'backbone-chained.coffee'
      glob_to_multiple: 
        expand: true
        flatten: true
        dest: 'js/'
        src: [
          "examples/*.coffee"
        ]
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
