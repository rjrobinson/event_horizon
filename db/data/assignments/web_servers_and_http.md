---
title: Web Servers and HTTP
slug: web-servers-and-http
type: review
---

You may have already seen how to put together web pages using HTML and CSS files on your local machine. But how do you share those pages with the world? In this assignment we'll setup a basic **web server** to host our pages and learn how browsers and web servers communicate via **HTTP**.

### Learning Goals

* Create a simple web application with **Sinatra**
* Manually send an HTTP GET request
* Review the different parts of an HTTP response
* Review different HTTP response codes

### Implementation Notes

For this assignment, we'll start with a simple HTML page representing a TODO list. In a new directory called *todo_list* save the following HTML in a file called *home.html*:

```HTML
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Basic HTML Page</title>
  </head>

  <body>
    <h1>TODO list</h1>

    <ul>
      <li>pay bills</li>
      <li>buy milk</li>
      <li>learn Ruby</li>
    </ul>
  </body>
</html>
```

Here we have a single header and a few items in an unordered list. If we want to see how the HTML will be rendered we can load this file directly in the browser:

```no-highlight
$ open home.html
```

{% hal_image '/http-sinatra/unstyled_todo.png' %}

This is a pretty bland looking page so let's add some CSS to change the default styles. If we wanted this to be a ["Matrix"-style][matrix_style] TODO list we can add the following CSS in a file called *home.css*:

```CSS
body {
    /* Use a "Matrix"-style color scheme. */
    background-color: black;
    color: #00ff00;

    font-family: monospace;
    font-size: 1.5em;
}

ul {
    /* Wrap the list in a green box. */
    width: 300px;
    border: 1px solid #00ff00;
}

li {
    /* Add a bit more spacing between list items. */
    padding: 5px;
}
```

Then in the HTML we can add a link back to this stylesheet in the `<head>` section:

```HTML
<head>
  <title>Basic HTML Page</title>
  <link rel="stylesheet" href="home.css">
</head>
```

After refreshing the page in the browser we should get a flashback to 1999.

{% hal_image '/http-sinatra/styled_todo.png' %}

#### Hosting Pages

If we look at the URL in the browser we might notice that it doesn't look like a typical web address. The browser is loading the files directly from our filesystem with a URL like:

```no-highlight
file:///Users/asheehan/work/todo_list/home.html
```

This is fine for testing out our web pages but doesn't really work when we want to share our site with the world. What we can do instead is use a **web server** to host our files somewhere publicly accessible so users can view them.

When we visit [http://www.google.com][google], we're communicating with a web server that will send back the HTML, CSS, and JavaScript for the Google homepage. A web server is a software application that listens for requests for web pages and will respond with the appropriate content. Every website has one or more web servers listening for requests, running various kinds of software that will determine how each request will be handled.

*Note: A web server can also refer to a physical machine running a web application, usually sitting in a data center somewhere with [lots of blinky lights][physical_server]. For these assignments when we talk about a web server we're referring to the software, not the hardware.*

Let's create a very simple web app that will return our HTML and CSS using **Sinatra**, a lightweight web framework written in Ruby. We can install Sinatra with the following command:

```no-highlight
$ gem install sinatra
```

After that's installed, let's move our HTML and CSS to a separate folder called *public* that will store all of our static files:

```no-highlight
$ mkdir public
$ mv home.html home.css public
```

Now we can create our Sinatra app in a file called *server.rb*, which should be saved in our project's root directory:

```ruby
require 'sinatra'

set :public_folder, File.dirname(__FILE__) + '/public'
```

Here we're first including the Sinatra framework (`require 'sinatra'`) and then specifying that our static files are in the *public* folder we just created (we could actually leave this line our since *public* is the default name of the directory, but here we're being explicit). Sinatra handles setting up a web server for us so there is not much else we need to do.

To test out our web app we can start up the server with the following command:

```no-highlight
$ ruby server.rb

[2014-02-03 15:43:49] INFO  WEBrick 1.3.1
[2014-02-03 15:43:49] INFO  ruby 2.0.0 (2013-11-22) [x86_64-darwin13.0.0]
== Sinatra/1.4.4 has taken the stage on 4567 for development with backup from WEBrick
[2014-02-03 15:43:49] INFO  WEBrick::HTTPServer#start: pid=11597 port=4567
```

To view our TODO list we can now visit [http://localhost:4567/home.html][homepage] which should return the same HTML and CSS we had before.

#### HTTP

So what happens when we visit [http://localhost:4567/home.html][homepage]? If we look at the output from `ruby server.rb` we'll see some lines that look like:

```no-highlight
::1 - - [03/Feb/2014 16:10:58] "GET /home.html HTTP/1.1" 200 277 0.0024
localhost - - [03/Feb/2014:16:10:58 EST] "GET /home.html HTTP/1.1" 200 277
- -> /home.html
::1 - - [03/Feb/2014 16:10:58] "GET /home.css HTTP/1.1" 200 329 0.0009
localhost - - [03/Feb/2014:16:10:58 EST] "GET /home.css HTTP/1.1" 200 329
http://localhost:4567/home.html -> /home.css
```

These are logs of HTTP requests that were received and handled by the web server. **HTTP** is the protocol that web servers and their clients use to communicate. In this case, the client is typically a web browser. When we want to view a page, we enter the URL into our browser which then sends an **HTTP request** to the web server at the given address. The server receives the request and then returns with an **HTTP response** containing the content for that page (usually HTML, CSS, or Javascript). When the browser receives the HTML and CSS, it draws it in the window.

An HTTP request is just a stream of characters sent over the network to a listening web server. Although our browser handles sending and receiving HTTP requests and responses in the background, we can simulate this process using a tool called *telnet*. We can use telnet to open a connection to a web server and then type in our request manually.

Our web server is running on our machine (aka *localhost*) on port 4567, so to connect with telnet we can run the following command in a new Terminal window:

```no-highlight
$ telnet localhost 4567
Trying ::1...
Connected to localhost.
Escape character is '^]'.
```

*Note: If you need to exit the telnet session type `Ctrl + ]` and then `Ctrl + D` to close the connection.*

Now that we're connected, let's type out a simple HTTP request:

```no-highlight
GET /home.html HTTP/1.0
Host: localhost


```

Every HTTP request includes both a method and a path. Here we're requesting the */home.html* path with the *GET* method which should return the HTML page we created earlier. We also specify the HTTP protocol version (*HTTP/1.0*) and the host (*Host: localhost*) which is required by most web servers.

After typing these two lines hit Enter twice. An HTTP request is terminated by two blank lines which will let the server know that we are done sending our request. Once the request is sent and we should receive an HTTP response from the server:

```no-highlight
HTTP/1.1 200 OK
Content-Type: text/html;charset=utf-8
Last-Modified: Mon, 03 Feb 2014 20:03:47 GMT
Content-Length: 277
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
Server: WEBrick/1.3.1 (Ruby/2.0.0/2013-11-22)
Date: Mon, 03 Feb 2014 21:46:18 GMT
Connection: close

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Basic HTML Page</title>
    <link rel="stylesheet" href="home.css">
  </head>

  <body>
    <h1>TODO list</h1>

    <ul>
      <li>pay bills</li>
      <li>buy milk</li>
      <li>learn Ruby</li>
    </ul>
  </body>
</html>
```

This response is divided up into two sections: the response headers and the response body. The first line of the headers indicates the status of the response:

```no-highlight
HTTP/1.1 200 OK
```

In this case we received a *200 OK* response indicating that everything went smoothly. Following the status line are a list of HTTP headers with additional details about the response: the type of content being sent back, the size of the response, when this file was last modified, etc.

After the last header there is a blank line and then the response body. This is where the HTML we created earlier gets included. The contents of the HTTP response body should be identical to the contents of the *home.html* file in our *public* directory.

Notice that we didn't receive any CSS back. This is because we are keeping our CSS in an *external* stylesheet that is linked to from our HTML page (`<link rel="stylesheet" href="home.css">` in the `<head>` section). To retrieve the stylesheet we issue a second HTTP GET request targeting the */home.css* path instead of */home.html*.

Since our connection was closed we restart our telnet session:

```no-highlight
$ telnet localhost 4567
Trying ::1...
Connected to localhost.
Escape character is '^]'.
```

Then we issue the following request:

```no-highlight
GET /home.css HTTP/1.0
Host: localhost

```

Once this request has been sent we should receive the following response:

```no-highlight
HTTP/1.1 200 OK
Content-Type: text/css;charset=utf-8
Last-Modified: Mon, 03 Feb 2014 20:03:54 GMT
Content-Length: 329
X-Content-Type-Options: nosniff
Server: WEBrick/1.3.1 (Ruby/2.0.0/2013-11-22)
Date: Mon, 03 Feb 2014 22:41:12 GMT
Connection: close

body {
    /* Use a "Matrix"-style color scheme. */
    background-color: black;
    color: #00ff00;

    font-family: monospace;
    font-size: 1.5em;
}

ul {
    /* Wrap the list in a green box. */
    width: 300px;
    border: 1px solid #00ff00;
}

li {
    /* Add a bit more spacing between list items. */
    padding: 5px;
}
```

When a browser receives this response it can then apply these styles to the HTML it received earlier. It's fairly typical for a browser to send many HTTP requests to load a single page. After getting back the initial response, a browser will search the HTML for any other resources that it needs to retrieve. External stylesheets, javascript files, images, and other assets each get their own HTTP requests.

Most modern browsers include a way to monitor the HTTP requests and responses going back and forth. In Chrome, clicking on *View > Developer > Developer Tools* and opening the *Network* tab will show all communication between the browser and the server. For Firefox the same information can be found in *Tools > Web Developer > Network*. Once the tool is running, visiting a new page will populate it with all of the requests being made. For example, visiting [http://www.google.com][google] resulted in over 20 requests being sent to load the home page with all of its assets!

#### HTTP Response Codes

So far we've only seen vanilla HTTP responses: a status code of 200 indicates that everything went OK. There are other response codes for when things don't go so smoothly.

Let's try requesting a page that we know doesn't exist. After connecting with `telnet localhost 4567` send the following request:

```no-highlight
GET /nonexistent.html HTTP/1.0
Host: localhost
```

We'll probably receive a response similar to:

```no-highlight
HTTP/1.1 404 Not Found
Content-Type: text/html;charset=utf-8
X-Cascade: pass
Content-Length: 448
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
Server: WEBrick/1.3.1 (Ruby/2.0.0/2013-11-22)
Date: Tue, 04 Feb 2014 15:26:29 GMT
Connection: close

<!DOCTYPE html>
<html>
<head>
  <style type="text/css">
  body { text-align:center;font-family:helvetica,arial;font-size:22px;
    color:#888;margin:20px}
  #c {margin:0 auto;width:500px;text-align:left}
  </style>
</head>
<body>
  <h2>Sinatra doesn&rsquo;t know this ditty.</h2>
  <img src='http://localhost/__sinatra__/404.png'>
  <div id="c">
    Try this:
    <pre>get '/nonexistent.html' do
  "Hello World"
end
</pre>
  </div>
</body>
</html>
```

Notice the first line: `HTTP/1.1 404 Not Found`. A 404 response code is a way for the server to tell the client that what they requested does not exist. The response also includes some HTML with an error message to display back to the user (although not all responses need to include a body).

Another common response code is a redirect sending the client to a different web page. Let's try sending a request to [http://google.com][google_no_www]. First open a telnet session with `telnet google.com 80` and send the following request:

```no-highlight
GET / HTTP/1.0
Host: google.com
```

After the request is sent we'll receive the following:

```no-highlight
HTTP/1.0 301 Moved Permanently
Location: http://www.google.com/
Content-Type: text/html; charset=UTF-8
Date: Tue, 04 Feb 2014 15:32:25 GMT
Expires: Thu, 06 Mar 2014 15:32:25 GMT
Cache-Control: public, max-age=2592000
Server: gws
Content-Length: 219
X-XSS-Protection: 1; mode=block
X-Frame-Options: SAMEORIGIN
Alternate-Protocol: 80:quic

<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
```

The first line of the response indicates a redirect: `HTTP/1.0 301 Moved Permanently`. This is letting the client know that the resource they are requesting can be found somewhere else. The next response header actually includes the updated location so the browser can send another request. In this case we're being redirected from [http://google.com][google_no_www] to [http://www.google.com][google]. This is a common way of allowing users to type in either address and still end up at the same place.

So far we've covered sending HTTP GET requests and a handful of the different [HTTP responses][status_codes] we might receive. In later assignments we'll discuss different types of HTTP requests and the responses they generate and how they're used within a web application.

### Resources

* [Wikipedia: HTTP][http]
* [Wikipedia: List of HTTP Response Codes][status_codes]

### Rules To Follow

#### Use Appropriate Response Codes

There are a large number of [HTTP response codes][status_codes] available for handling most situations. Responding with the appropriate status code ensures browsers and other programs (e.g. web crawlers) work well with your application.

### Why This Is Important

HTTP is the language of the web and is how browsers communicate with web applications. Understanding the information traveling back and forth between the client and server is important for understanding how to structure a web application.

[homepage]: http://localhost:4567/home.html
[matrix_style]: https://www.google.com/search?tbm=isch&q=the+matrix+style
[google]: http://www.google.com
[physical_server]: http://media.treehugger.com/assets/images/2011/10/data-center-servers-t001.jpg
[http]: http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol
[status_codes]: http://en.wikipedia.org/wiki/List_of_HTTP_status_codes
[google_no_www]: http://google.com
