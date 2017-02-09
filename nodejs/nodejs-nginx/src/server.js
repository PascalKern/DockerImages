
let express = require('express');
let app = express();

/*
if (process.env.NODE_ENV === 'developement') {
	# Must later also not run node but nodemon to have live update from JS files!
	app.use('/', express.static('path/to/mounted/sources'));
} else {
	app.use('/', express.static('/'));
}
*/

app.get('/test', (req, res) => {
	logRequestAccept(req);
  	res.send('TestTest'); // + new Date());
});

app.get('/', (req, res) => {
	logRequestAccept(req);
  	res.send('Hello World, this is a nodeJS example using express');
});

let server = app.listen(3000, function () {

  let host = server.address().address;
  let port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);

});


let logRequestAccept = function (req) {
    console.log("Accept get request from: " + req.headers.host + " to: " + req.url);
}
