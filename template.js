/*
 * grunt-init-node
 * https://gruntjs.com/
 *
 * Copyright (c) 2013 "Cowboy" Ben Alman, contributors
 * Licensed under the MIT license.
 */

'use strict';

// Basic template description.
exports.description = 'Create a StarkRobot module using coffeescript and mocha unit tests.';

// Template-specific notes to be displayed before question prompts.
exports.notes = '_Project name_ shouldn\'t contain "node" or "js" and should ' +
  'be a unique ID not already in use at search.npmjs.org.';

// Template-specific notes to be displayed after question prompts.
exports.after = 'You should now install project dependencies with _npm ' +
  'install_. After that, you may execute project tasks with _grunt_. For ' +
  'more information about installing and configuring Grunt, please see ' +
  'the Getting Started guide:' +
  '\n\n' +
  'http://gruntjs.com/getting-started';

// Any existing file or directory matching this wildcard will cause a warning.
exports.warnOn = '*';

// The actual init template.
exports.template = function(grunt, init, done) {

  init.process({type: 'node'}, [
    // Prompt for these values.
    init.prompt('name'),
    init.prompt('description'),
    init.prompt('version'),
    init.prompt('repository'),
    init.prompt('homepage'),
    init.prompt('bugs'),
    init.prompt('author_name'),
    init.prompt('author_email'),
    init.prompt('author_url'),
    init.prompt('node_version', '>= 0.10.1'),
    init.prompt('main'),
    init.prompt('test_port_number', '4887'),
    init.prompt('npm_test', 'cake test')
  ], function(err, props) {
    props.keywords = [];
    props.dependencies = {
      "connect": "2.8.4",
      "express": "3.3.4",
      "hbs": "2.3.1",
      "underscore": "1.4.4"
    };
    
    props.devDependencies = {
      "coffee-script": "1.6.2",
      "docco": "0.6.2",
      "expect.js": "0.2.0",
      "grunt": "0.4.1",
      "grunt-coffeelint": "0.0.6",
      "grunt-commonjs": "0.2.0rc7",
      "grunt-contrib-coffee": "0.6.4",
      "grunt-contrib-concat": "0.1.3",
      "grunt-contrib-clean": "0.4.0",
      "grunt-contrib-connect": "0.3.0",
      "grunt-contrib-uglify": "0.2.0",
      "grunt-contrib-watch": "0.3.1",
      "grunt-contrib-copy": "0.4.1",
      "grunt-livereload": "0.1.2",
      "grunt-mocha": "0.3.0",
      "grunt-strip": "0.2.0",
      "mocha": "1.8.2",
      "chai": "1.7.0"
    };

    // Files to copy (and process).
    var files = init.filesToCopy(props);

    // Actually copy (and process) files.
    init.copyAndProcess(files, props);

    // Generate package.json file.
    init.writePackageJSON('package.json', props);

    // All done!
    done();
  });

};
