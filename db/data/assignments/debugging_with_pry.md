---
title: Debugging with Pry
slug: debugging-with-pry
type: review
---

Debugging is the process of identifying and removing errors from your programs. There are tools that make this process easier and in this assignment we introduce you to one such tool: Pry.

### Learning Goals

* Installing pry
* Using pry to pause program execution and explore local variables
* Using pry-debugger to step through program execution

### Resources

* [Pry - an IRB alternative](http://pryrepl.org/)
* [pry-debugger plugin](https://github.com/nixme/pry-debugger)
* [Pry — The Good Parts!](http://www.confreaks.com/videos/2467-railsconf2013-pry-the-good-parts)

### Implementation Details

#### Why use pry?

Programs can move and change quickly. We can use a debugging tool like pry to "stop time" as a program executes. While time is stopped, we can poke around and learn more about the state of our program before it continues to execute. This can be useful to explore the state of variables in your system and to identify where potential bugs may be introduced.

#### Setup

To use Pry you must first install the gem. Do so by running the following command in your terminal:

```no-highlight
$ gem install pry
```

We'll also need a plugin for pry called pry-debugger that will help us step through our code. Install the gem like so in your terminal:

```no-highlight
$ gem install pry-debugger
```

#### Pausing Execution

Now that we're done with setup, let's examine the following program:

```ruby
names = ["Johnny", "Jack", "Jillianne", nil].shuffle

names.each do |name|
  puts "Hello #{name}, your name is #{name.length} characters long."
end
```

Prior to executing the above program, try to imagine in your mind's eye how this program will run. Visualizing or imagining how a program will execute is an important skill to develop. Ask yourself:

* For each value in the `names` array, what will be outputted?
* Will the code inside of the `each` block work for each value in the `names` array?
* How many lines of output will the program produce?

---

If you run this program, your output might look like so:

```no-highlight
Hello Jillianne, your name is 9 characters long.
Hello Jack, your name is 4 characters long.
NoMethodError: undefined method `length' for nil:NilClass
```

So what's happening here? First, you might have expected a different order of output for the names unless you noticed the `shuffle` at the end of the `names` array literal. That method will do what it implies, randomly shuffle the values in the array so that each time you run the program you get a different output.

Let's turn our attention to the `NoMethodError` being caused by the `nil` that we specified as the last element of the array. After the shuffle, that `nil` found itself repositioned as the third element and caused our failure when we attempted to call the `length` method on it. It's pretty easy to identify the cause at a glance in this case but imagine that this list was a very large one where you might not even know if there's _bad_ data in it.

Enter **Pry**. We'll use **pry** to pause execution of our program as we iterate over the `names` array. Before using Pry in our code, we must ensure it is loaded in through the use of the `require` statement.

```ruby
require 'pry'

names = ["Johnny", "Jack", "Jillianne", nil].shuffle

names.each do |name|
  puts "Hello #{name}, your name is #{name.length} characters long."
end
```

Once we've required Pry, we can insert the following statement anywhere in our program to pause execution at that point:

```no-highlight
binding.pry
```


### Examining the Environment

By strategically placing this statement in our program, we can pause the iteration on our array before the error occurs.

```ruby
require 'pry'

names = ["Johnny", "Jack", "Jillianne", nil].shuffle

names.each do |name|
  binding.pry
  puts "Hello #{name}, your name is #{name.length} characters long."
end
```

Running the program should pause execution on the first iteration of our loop, drop us into the **pry** interface and await our command. This interface is not unlike IRB in that we can execute arbitrary ruby, but it also gives us some additional capabilities. We call interactive programs like this a [REPL](http://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop). Inside a REPL, we can continuously execute commands to obtain more information.

While the program is paused, you have ready access to any and all variables defined. If for example, the first element from our `names` array was "Jullianne", typing `name` inside of the REPL would yield the following:

```no-highlight
[1] pry(main)> name
=> "Julliane"
```

We could also examine the contents of the entire `names` array by simply typing it in as well:

```no-highlight
[1] pry(main)> names
=> ["Johnny", nil, "Jack", "Jillianne"]
```

Additionally, you can list out all the variables using the `ls` command:

```no-highlight
[1] pry(main)> ls
self.methods: inspect  to_s
locals: _  __  _dir_  _ex_  _file_  _in_  _out_  _pry_  name  names
[2] pry(main)>
```

Note that in this run of the program, the `nil` ended up getting repositioned as the second element. We would have encountered the `NoMethodError` exception upon the second iteration of this loop. With execution still paused, let's see how we can step through the rest of it.

#### Execution Control

During setup, we not only installed the **pry** gem but also the **pry-debugger** plugin for Pry. This plugin gives us the ability to step through execution of our code with keywords such as `step`, `next`, `finish` and `continue` and is auto-loaded by **pry**.

With execution paused on line 6 of our program, type in `next`. Our REPL now looks like this:

```no-highlight
    2:
    3: names = ["Johnny", "Jack", "Jillianne", nil].shuffle
    4:
    5: names.each do |name|
    6:   binding.pry
 => 7:   puts "Hello #{name}, your name is #{name.length} characters long."
    8: end
```

By using the `next` command, we instructed **pry** to move on to the next line of execution. Type `continue` to allow the program to finish the current iteration. It will then begin the second iteration of the `.each` loop and will pause once more on line 6 (where `binding.pry` is located).

At this point, if we examine the `name` variable, we'll notice that it is `nil` and can safely assume that we'll get the `NoMethodError` triggered once the program attempts to call the `length` method on it.

When you're ready to quit **pry**, enter `exit` and you'll return to the shell.

### Rules to Follow

#### Use pry to explore the state of your ruby programs

Pry can serve as a useful tool when trying to study the execution of your ruby programs. It can also be a wonderful tool for beginners who might want to explore what's happening as a program executes. We can use pry both for debugging and exploratory purposes.

### Why This Matters

The process of debugging can be a tedious one and leveraging the right tools can make that process easier. We did not touch on setting _breakpoints_ in this assignment but you should spend some time learning about it and the other commands on the [pry-debugger project page](https://github.com/nixme/pry-debugger).
