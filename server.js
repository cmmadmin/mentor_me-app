var statik = require('statik');
var server = statik.createServer();
var port = process.env.PORT || 1337;
server.listen(port);