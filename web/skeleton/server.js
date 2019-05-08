"use strict";

var http = require("http");
var fs = require("fs");

var server = http.createServer(function (request, response) {
  console.log(request.method, request.url);

  if(request.method === "GET") {
    if(request.url === "/" || request.url === "/index.html") {
      serveStatic("index.html", "text/html");
    } else if(request.url === "/index.css") {
      serveStatic("index.css", "text/css")
    } else if(request.url === "/index.js") {
      serveStatic("index.js", "text/javascript");
    } else if(request.url === "/404.html") {
      serveStatic("404.html", "text/html");
    } else if(request.url === "/404.css") {
      serveStatic("404.css", "text/css");
    } else if(request.url === "/404.js") {
      serveStatic("404.js", "text/javascript");
    } else {
      serve404();
    }
  } else if(request.method === "POST") {
    if(request.url === "/index.html") {
      getPostData().then(function(postData) {
        console.log(postData["id"], postData["method"], postData["params"]);
      });
    } else {
      response.writeHead(400);
      response.end();
    }
  }
  
  function serveStatic(fileName, mimeType) {
    fs.readFile("dist/" + fileName, function(error, content) {
      if(error) {
        console.log(error);
      } else {
        response.writeHead(200, {"content-type": mimeType});
        response.end(content, "utf-8");
      }
    });
  }
  
  function setCookie() {
    if("cookie" in request.headers) {
      var cookie = JSON.parse(request.headers["cookie"]);
    } else {
      // create cookie here
    }
    response.setHeader("set-cookie", JSON.stringify({"key" : "value"}));
    response.setHeader("cache-control", "no-cache, no-store, must-revalidate");
  }
  
  function serve404() {
    console.log("404 ", request.url);
    fs.readFile("dist/404.html", function(error, content) {
      if(error) {
        console.log(error);
      } else {
        response.writeHead(404, {"content-type": "text/html"});
        response.end(content, "utf-8");
      }
    });
  }
  
  function getPostData() {
    return new Promise(function(resolve) {
      var postData = "";
      request.on("data", function(chunk){
        postData += chunk.toString();
      });
      request.on("end", function() {
        resolve(JSON.parse(postData));
      }); 
    });
  }

});

server.listen(8000);
console.log("Server running at http://localhost:8000");
