var statik = require('statik');
var port = process.env.PORT || 1337;
statik({
  port: port
})