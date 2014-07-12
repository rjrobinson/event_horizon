---
title: HTML Forms and POST Requests
slug: html-forms-and-post-requests
type: review
---

In this assignment we'll discuss HTML forms as a way of getting user input and how their input is transferred via HTTP POST requests.

### Learning Goals

* Add an HTML form to a web page
* Pass user input to the web server via a POST request
* Persist user input using the filesystem

### Implementation Notes

For this assignment we'll revisit the *todo_list* project (a copy of the project can be viewed [here][todo_list] and downloaded [here][todo_list_download]). Right now the project has a single page that renders a list of tasks in a wonderful neon green-on-black fashion. The HTML is generated dynamically from a template but there is currently no user input to add to the list of tasks. We're going to add a feature that allows users to submit a new task and save it so that it appears on the list when the page refreshes. We'll need to make two changes to our application: modify the HTML to include a form for submitting the task and update the server to save the incoming tasks to a file.

#### Adding a Form

HTML forms are the conventional way for a user to submit information to a website. Forms allow for a variety of different inputs: typing in a text field, selecting options from a drop-down list, attaching a file for upload, etc. When a user is finished filling out a form, they can click a button to *submit* the form back to a web server along with all of their input.

To add a form to a web page we use the `<form>` element. Within the form we can define all of our inputs (e.g. text fields, select lists, etc.) but we also need to specify what happens when a user submits their info. Submitting a form is similar to clicking on a link in that it sends an HTTP request back to the server. The primary difference is that with a form we have the option to send an HTTP POST request rather than an HTTP GET. GET requests are intended for viewing web pages whereas POST requests are used when we want to modify or update something in our web app. Since we want to add a new task to our app a POST request would be more appropriate here.

Every HTTP request has both a method and a path. In this case our method will be POST but we still need to define a path. Since we're creating a new task with this request, we'll define a new path called `/tasks`. To create a form that will send a POST request to the `/tasks` path we could start with the following HTML:

```HTML
<form action="/tasks" method="post">
```

The *action* attribute specifies the path that the form submission will go to and the *method* attribute is used to choose between sending a POST request and a GET request. The default behavior is to submit a POST request from a form: GET requests should only be used when a form does not modify or update anything on the server (e.g. using a form to search a site).

The `<form>` element by itself doesn't do much other than describe the endpoint for the form. To add various components we can use `<input>` elements. An input can represent a text field, a select list, checkboxes, a submit button, and many other widgets (a full list of input types can be found [here][input_types]).

For our form we'll need to add two components: a text field where the user can type in the name of the task and a button so they can submit the form:

```HTML
<form action="/tasks" method="post">
  <label for="task_name">New Task:</label>
  <input type="text" id="task_name" name="task_name" />

  <input type="submit" />
</form>
```

Here we've added two `<input>` elements: a text field with `type="text"` and a submit button with `type="submit"`. We've also included a `<label>` element for the text field indicating what the user should fill out. To ensure that the label is attached to the right input we match `for="task_name"` attribute on the label with `id="task_name"` on the text field.

Another important attribute is the `name="task_name"` attribute on the text field. This is used to identify what the user typed into that particular field when it is passed along to the server. If there were multiple input fields we could distinguish between them based on their name attributes.

Let's go ahead and add our form to the template file in *views/index.erb*:

```HTML
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Basic HTML Page</title>
    <link rel="stylesheet" href="home.css" />
  </head>

  <body>
    <h1>TODO list</h1>

    <ul>
      <% @tasks.each do |task| %>
        <li><%= task %></li>
      <% end %>
    </ul>

    <form action="/tasks" method="post">
      <label for="task_name">New Task:</label>
      <input type="text" id="task_name" name="task_name" />

      <input type="submit" />
    </form>
  </body>
</html>
```

If we start up our server (by running `ruby server.rb`) and visit [http://localhost:4567][localhost] we should see our shiny new form:

![New Task Form](https://s3.amazonaws.com/hal-assets.launchacademy.com/http-sinatra/new_task_form.png)

After filling in the text field and hitting submit we'll be confronted with the following error:

![No Route for /tasks](https://s3.amazonaws.com/hal-assets.launchacademy.com/http-sinatra/no_route_error.png)

When the form is submitted we're sending an HTTP POST request to the `/tasks` path. This is what we want, except that we haven't defined anything in our *server.rb* file to handle this request which is why Sinatra is raising an error.

#### HTTP POST

Before we change our *server.rb* file, let's see what a POST request looks like. When a user submits the form their browser will send something like the following:

```no-highlight
POST /tasks HTTP/1.1
Host: localhost
Content-Length: 29

task_name=take+over+the+world
```

The first line defines both the method (*POST*) and the path (`/tasks`). The main distinction between a POST and a GET request is the request body. This is where all of the user input is stored in key-value pairs:

```no-highlight
task_name=take+over+the+world
```

Since we have a text field input with an attribute `name="task_name"` the browser will take whatever the user entered in that field and form the `task_name=<user input>` pair. If the user typed "take over the world" we'll end up with the key-value pair `task_name=take+over+the+world`. Notice how the spaces have been replaced by *+* symbols; this is known as URL encoding and allows us to send special characters (such as whitespace) in the request body.

We also have to include the size of the HTTP request body using the *Content-Length* header so that the web server knows how much data to expect. In this case our `task_name=take+over+the+world` body is 29 characters long so we just have to specify `Content-Length: 29`.

#### Updating Our Webserver

We have the form setup on the client-side, now how do we handle the incoming POST request on the server? We previously defined a block of code to handle `GET /` requests using `get '/'` in our *server.rb* file. We can do something similar to handle a `POST /tasks` request by adding `post '/tasks'`:

```ruby
post '/tasks' do
end
```

If we restarted our server and submitted the form again, we won't get an error anymore. Instead we'll be shown a blank page since we have an empty block of code. There are two things we want to do when we receive a `POST /tasks` request: save the new task that the user input and then redisplay the list. We'll start with the latter since we already have a way to view the tasks by visiting the home page. In this case we can just redirect to the user back to the `/` path in our response:

```ruby
post '/tasks' do
  redirect '/'
end
```

Now whenever the user submits the form they'll be redirected back to the home page.

We still have the issue of saving the task. We could append to the `@tasks` array but we'll lose this information once we restart the server since it is stored in memory. A more permanent solution would be to read and write the tasks to a file:

```ruby
post '/tasks' do
  # Read the input from the form the user filled out
  task = params['task_name']

  # Open the "tasks" file and append the task
  File.open('tasks', 'a') do |file|
    file.puts(task)
  end

  # Send the user back to the home page which shows
  # the list of tasks
  redirect '/'
end
```

Everything that the user submits through a form is accessible via the `params` hash. For our form the params hash might look something like:

```ruby
{ "task_name" => "take over the world" }
```

A great way to see this in action is to use `binding.pry`. At the top of the server.rb file, add `require 'pry'`. Add a binding.pry right after `post '/tasks' do`. Your file should look like this:

```ruby
require 'sinatra'
require 'pry'

get '/' do
  @tasks = File.readlines('tasks')
  erb :index
end

post '/tasks' do
  binding.pry
  # Read the input from the form the user filled out
  task = params['task_name']

  # Open the "tasks" file and append the task
  File.open('tasks', 'a') do |file|
    file.puts(task)
  end

  # Send the user back to the home page which shows
  # the list of tasks
  redirect '/'
end

# These lines can be removed since they are using the default values. They've
# been included to explicitly show the configuration options.
set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'

```

Restart your server and submit a new task. You'll see in your terminal that the execution is paused. If you type `params` it will return the current params hash. This is what gets passed on form submission.

The keys in the hash correspond to the names of the inputs on our form. Our text field had the attribute `name="task_name"` so when the form is submitted we can access the user's input via `params['task_name']`. Here we're saving the task in a separate variable `task = params['task_name']` for use later.

Next we need to write this task to a file. We'll use a file named *tasks* to store the list of tasks, one per line. `File.open('tasks', 'a')` will open the *tasks* file for *appending* (using the `'a'` filemode). When opening a file for appending all changes will be written at the end of the file which is what `file.puts(task)` statement will do for us.

Once the task has been written we send the user back to the home page where we'll display the list again. Now we just need to change our home page to read the tasks from the file rather than using the hard-coded values:

```ruby
get '/' do
  @tasks = File.readlines('tasks')
  erb :index
end
```

The `File.readlines('tasks')` line will open the *tasks* file and return an array containing each line of the file. Since we're storing one task per line, this is exactly what we want.

One final thing to do before starting up the server again is to create a blank *tasks* file. If there no such file we'll receive an error when running `File.readlines('tasks')`. After stopping the server we can run the `touch` command to create the file if it doesn't exist:

```no-highlight
$ touch tasks
$ ruby server.rb
```

Now when we visit [http://localhost:4567][localhost] and submit the form we should see the list of tasks updating. If we were to open the *tasks* file we should see that it contains all of the entries that have been submitted so far. Since a file is persisted even after the program stops running the tasks will remain when the server is restarted.

### Resources

* [MDN: My first HTML form][first_form]
* [MDN: Sending and retrieving form data][sending_receiving_data]

### Rules To Follow

#### GET For Retrieval, POST For Modification

Whenever the user is requesting to view something they should be sending a GET request. If the user wants to create or modify some resource they should be using a POST request (or a variation of POST such as PUT/PATCH/DELETE which we'll cover later).

#### Forms Can Send GET Requests Too

For scenarios where we're not modifying anything but we still need to get user input, it might make sense to have a form send a GET request. The classic example of this is a search form: we need to allow the user to enter arbitrary input but we we're not modifying anything. To have a form send a GET request we just need to change the *method* attribute on `<form>`:

```HTML
<form action="/search" method="get">
```

#### Never Implicitly Trust User Input

Just as we were able to manually send a GET request with `telnet`, malicious users can also hand-edit their own POST requests before sending them back to the server. It's important to validate what a user sends back to ensure that they haven't injected or tampered with any of the fields. Just because a field is missing or hidden on a form does not mean that a determined user cannot submit a value. We often do this by only allowing certain values or keys in our params hash.

### Why This Is Important

Accepting user input and persisting data are two essential activities for most non-trivial web apps. Understanding how data is transferred from a client to the server and the difference between GET and POST requests is important for building web apps.

[sending_receiving_data]: https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/Sending_and_retrieving_form_data
[first_form]: https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/My_first_HTML_form
[todo_list]: https://github.com/LaunchAcademy/todo_list_sinatra/tree/render_template
[todo_list_download]: https://github.com/LaunchAcademy/todo_list_sinatra/archive/render_template.zip
[input_types]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#attr-type
[localhost]: http://localhost:4567
