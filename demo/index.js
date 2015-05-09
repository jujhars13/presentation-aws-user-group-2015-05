var http = require('http')
var url = require('url')
var baseDirectory = __dirname   // or whatever base directory you want

//specify the port we're running on
var port=process.env.NODE_PORT?parseInt(process.env.NODE_PORT):8080;

http.createServer(function (request, response) {
	var date= new Date();

	response.writeHead(200);
	response.writeHead('My-web-server');
	response.write('<h1>My server is configured, yay!</h1>');
	response.write('<p>' + date.toUTCString() + '</p>');
	response.end(); // inside finally so errors don't make browsers hang

}).listen(port)
