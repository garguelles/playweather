"use strict"

lrSnippet = require("grunt-contrib-livereload/lib/utils").livereloadSnippet
mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)

module.exports = (grunt) ->

  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  settingsFile = 'grunt-settings.json'
  settings = {}
  if grunt.file.exists settingsFile
    settings = grunt.file.readJSON settingsFile

  # configurable paths
  yeomanConfig =
    app: "app"
    dist: "dist"
    tmp: ".tmp"
    phonegap: settings.phonegap

  grunt.initConfig
    yeoman: yeomanConfig

    env:
      options:
        DEBUG: true
        APP_CACHE: false
      dev:
        NODE_ENV: 'development'
      test:
        NODE_ENV: 'test'
      build:
        NODE_ENV: 'production'
        DEBUG: false
        APP_CACHE: true

    preprocess:
      html:
        src: 'app/index.html.pre'
        dest: 'app/index.html'

    watch:
      coffee:
        files: ["<%= yeoman.app %>/scripts/**/*.coffee"]
        tasks: ["coffee"]

      coffeeTest:
        files: ["test/spec/**/*.coffee"]
        tasks: ["coffee:test"]

      compass:
        files: ["<%= yeoman.app %>/styles/{,*/}*.{scss,sass}"]
        tasks: ["compass"]

      haml:
        files: ["<%= yeoman.app %>/scripts/templates/**/*.hamlc"]
        tasks: ["haml"]

      livereload:
        files: [
          "<%= yeoman.app %>/*.html"
          "{<%= yeoman.tmp %>,<%= yeoman.app %>}/styles/{,*/}*.css"
          "{<%= yeoman.tmp %>,<%= yeoman.app %>}/scripts/**/*.js"
          "<%= yeoman.app %>/images/**/*.{png,jpg,jpeg,gif,webp,svg}"
        ]
        tasks: ["livereload"]

    connect:
      options:
        port: 9000
        # change this to '0.0.0.0' to access the server from outside
        hostname: "localhost"

      livereload:
        options:
          middleware: (connect) ->
            [
              lrSnippet
              mountFolder(connect, ".tmp")
              mountFolder(connect, "app")
            ]

      test:
        options:
          middleware: (connect) ->
            [
              mountFolder(connect, ".tmp")
              mountFolder(connect, "test")
            ]

      dist:
        options:
          middleware: (connect) ->
            [
              mountFolder(connect, "dist")
            ]

    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"

    clean:
      dist: [
        "<%= yeoman.tmp %>"
        "<%= yeoman.dist %>/*"
      ]
      server: "<%= yeoman.tmp %>"

    jshint:
      options:
        jshintrc: ".jshintrc"

      all: [
        "Gruntfile.js"
        "<%= yeoman.app %>/scripts/**/*.js"
        "!<%= yeoman.app %>/scripts/vendor/*"
        "test/spec/{,*/}*.js"
      ]

    mocha:
      all:
        options:
          run: true
          urls: [
            "http://localhost:<%= connect.options.port %>/index.html"
          ]

    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.app %>/scripts"
          src: "**/*.coffee"
          dest: "<%= yeoman.tmp %>/scripts"
          ext: ".js"
        ]

      test:
        files: [
          expand: true
          cwd: "<%= yeoman.tmp %>/spec"
          src: "**/*.coffee"
          dest: "test/spec"
        ]

    haml:
      dist:
        options:
          language: "coffee"
          target: "js"
          placement: "amd"
          dependencies:
            h: "helpers/templates_helpers"
            t: "templates"
            l: "i18n!nls/locale"
            settings: "config/settings"

        files: [
          expand: true
          cwd: "<%= yeoman.app %>/scripts/templates"
          src: "**/*.hamlc"
          dest: "<%= yeoman.tmp %>/scripts/templates"
          ext: ".js"
        ]

    compass:
      options:
        sassDir: "<%= yeoman.app %>/styles"
        cssDir: "<%= yeoman.tmp %>/styles"
        imagesDir: "<%= yeoman.app %>/images"
        javascriptsDir: "<%= yeoman.app %>/scripts"
        fontsDir: "<%= yeoman.app %>/fonts"
        importPath: "app/components"
        relativeAssets: true

      dist: {}
      server:
        options:
          debugInfo: true

    requirejs:
      dist:
        # Options: https://github.com/jrburke/r.js/blob/master/build/example.build.js
        options:
          # `name` and `out` is set by grunt-usemin
          baseUrl: "<%= yeoman.tmp %>/scripts"
          optimize: "none"
          preserveLicenseComments: false
          useStrict: true
          wrap: true

    useminPrepare:
      html: "<%= yeoman.app %>/index.html"
      options:
        dest: "<%= yeoman.dist %>"

    usemin:
      html: ["<%= yeoman.dist %>/{,*/}*.html"]
      css: ["<%= yeoman.dist %>/styles/{,*/}*.css"]
      options:
        dirs: ["<%= yeoman.dist %>"]

    imagemin:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.app %>/images"
          src: "{,*/}*.{png,jpg,jpeg}"
          dest: "<%= yeoman.dist %>/images"
        ]

    cssmin:
      dist:
        files:
          "<%= yeoman.dist %>/styles/main.css": [
            "<%= yeoman.tmp %>/styles/{,*/}*.css"
            "<%= yeoman.app %>/styles/{,*/}*.css"
          ]

    htmlmin:
      dist:
        options: {}
        files: [
          expand: true
          cwd: "<%= yeoman.app %>"
          src: "*.html"
          dest: "<%= yeoman.dist %>"
        ]

    copy:

      dist:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.app %>"
          dest: "<%= yeoman.dist %>"
          src: [
            "manifest.appcache"
            "*.{ico,txt}"
            ".htaccess"
            "images/{,*/}*.{webp,gif,svg}"
            "images/{,*/}*.{swf,xap}"
            "fonts/*.*"
          ]
        ]

      js:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.app %>/scripts"
          dest: "<%= yeoman.tmp %>/scripts"
          src: ["{,*/}*.js"]
        ]

      fontsAwesomeServer:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.app %>/components/font-awesome/build/assets/font-awesome/font"
          dest: "<%= yeoman.tmp %>/fonts/font-awesome"
          src: [
            "*.eot"
            "*.svg"
            "*.ttf"
            "*.woff"
            "*.otf"
          ]
        ]

      fontsAwesomeBuild:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.app %>/components/font-awesome/build/assets/font-awesome/font"
          dest: "<%= yeoman.dist %>/fonts/font-awesome"
          src: [
            "*.eot"
            "*.svg"
            "*.ttf"
            "*.woff"
            "*.otf"
          ]
        ]

    symlink:
      js:
        dest: "<%= yeoman.tmp %>/components"
        relativeSrc: "../app/components"
        options:
          type: "dir"

    bower:
      all:
        rjsConfig: "<%= yeoman.tmp %>/scripts/main.js"

    zip:
      release:
        src: [
          '<%= yeoman.dist %>/**/*.*'
        ]
        dest: "<%= yeoman.phonegap.archive %>"

    'phonegap-build':
      release:
        options:
          archive: "<%= yeoman.phonegap.archive %>"
          appId: "<%= yeoman.phonegap.appId %>"
          user:
            token: "<%= yeoman.phonegap.user.token %>"

  grunt.renameTask "regarde", "watch"

  grunt.registerTask "server", (target) ->
    return grunt.task.run([
      "build"
      # "open"
      "connect:dist:keepalive"
    ])  if target is "dist"
    grunt.task.run [
      "env:dev"
      "clean:server"
      "preprocess:html"
      "coffee:dist"
      "haml"
      "copy:fontsAwesomeServer"
      "compass:server"
      "livereload-start"
      "connect:livereload"
      # "open"
      "watch"
    ]

  grunt.registerTask "test", [
    "env:test"
    "clean:server"
    "preprocess:html"
    "coffee"
    "compass"
    "connect:test"
    "mocha"
  ]

  grunt.registerTask "build", [
    "env:build"
    "clean:dist"
    "preprocess:html"
    "coffee"
    "haml"
    "copy:js"
    "symlink:js"
    "compass:dist"
    "useminPrepare"
    "requirejs"
    "imagemin"
    "htmlmin"
    "concat"
    "cssmin"
    "uglify"
    "copy"
    "copy:fontsAwesomeBuild"
    "usemin"
  ]

  grunt.registerTask "default", [
    "jshint"
    "test"
    "build"
  ]

  grunt.registerTask "release", [
    "zip:release"
    "phonegap-build:release"
  ]
