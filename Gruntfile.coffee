module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    paths:
      static: "static"
      build: "static/build"
      src: "static/src"
      deploy: "static/dist"
      components: "static/components"

    # CoffeeScript
    coffee:
      options:
        sourceMap: false
        sourceRoot: ""

      glob_to_multiple:
        expand: true,
        flatten: false,
        cwd: "<%= paths.src %>/scripts/",
        src: ["**/*.coffee"],
        dest: "<%= paths.build %>/scripts/",
        ext: ".js"
    
    # Compile Sass to CSS -  destination : source
    sass:
      build:
        options:
          style: "compressed"
          sourceComments: "normal"

        files:
          "<%= paths.build %>/styles/main.css": "<%= paths.src %>/styles/main.sass"

    ##
    ## Deployment Configuration
    ##
    cssmin:
      deploy:
        files:
          "<%= paths.deploy %>/styles/main.css": "<%= paths.build %>/styles/main.css"

    uglify:
      deploy:
        files:
          "<%= paths.deploy %>/scripts/main.js": ["<%= paths.deploy %>/scripts/main.js"]
    
    ##
    ## Watcher Configuation
    ##
    # Simple config to run sass, and coffee any time a js or sass file is added, modified or deleted
    watch:
      coffee:
        files: ["<%= paths.src %>/scripts/**/*.coffee"]
        tasks: ["coffee"]

      sass:
        files: ["<%= paths.src %>/styles/**/*.scss", "<%= paths.src %>/styles/**/*.sass"]
        tasks: ["sass:build"]

    concurrent:
      build: ["coffee", "sass:build"]


  # Load the plug-ins
  require("load-grunt-tasks") grunt
  
  # Default tasks
  grunt.registerTask "default", ["concurrent:build"]
  grunt.registerTask "deploy", ["concurrent:build", "cssmin:deploy", "uglify:deploy"]
