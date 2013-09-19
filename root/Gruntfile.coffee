module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
      '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
      ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n'

    clean:
      dist: ['dist/', 'tmp/']
      test: ['test/public/js/test.js', 'test/public/js/<%= pkg.name %>.js', 'tmp/']

    coffee:
      dist:
        expand: yes
        cwd: 'src/'
        src: '**/*.coffee'
        dest: 'tmp/'
        ext: '.js'
      test:
        files:
          'test/public/js/test.js': 'test/functional/**/*.coffee'

    commonjs:
      modules:
        cwd: 'tmp/'
        src: ['**/*.js']
        dest: 'tmp/'

    concat:
      devJs:
        files:
          'test/public/js/<%= pkg.name %>.js': '<%= jsFiles %>'

    livereload:
      options:
        base: 'test',
      files: ['test/public/**/*']

    jsFiles: [
      'vendor/common.js'
      'tmp/**/*.js'
    ]

    mocha:
      test:
        src: "http://localhost:<%= test_port_number %>/index.html"
        mocha:
          ignoreLeaks: false
          timeout: 20000
        run: true

    uglify:
      options:
        mangle: false
      dist:
        files:
          'dist/<%= pkg.name %>.js': '<%= jsFiles %>'
      test:
        options:
          beautify: true
        files:
          'test/public/js/<%= pkg.name %>.js': '<%= jsFiles %>'

    watch:
      src:
        files: ['src/**/*.coffee']
        tasks: ['test']
        options:
          debounceDelay: 250

      test:
        files: ['test/functional/**/*.coffee']
        tasks: ['test']
        options:
          debounceDelay: 250

  grunt.loadNpmTasks 'grunt-commonjs'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-livereload'
  grunt.loadNpmTasks 'grunt-mocha'

  grunt.registerTask 'scripts', ['coffee:dist', 'commonjs']
  grunt.registerTask 'prep',    ['scripts']
  grunt.registerTask 'test',       ['clean:test', 'prep', 'concat:devJs', 'coffee:test']  
  grunt.registerTask 'run',       ['test', 'livereload', 'watch']
