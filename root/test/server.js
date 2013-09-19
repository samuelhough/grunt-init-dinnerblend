var connect = require('connect')
  , fs = require('fs')


console.log( 'View browser tests at: ');
console.log( ' ' );
console.log(' http://localhost:'+ {%= test_port_number %}+'/index.html' );

connect.createServer(
  connect.static(__dirname + '/public')
).listen({%= test_port_number %});
