---
title: Methods
slug: methods
type: review
---

In this review assignment, you'll be introduced to Ruby methods as a way of abstracting your code.

### Learning Goals

* Define a method
* Discuss the structure of a method
* Define a method that takes parameters

### Implementation Details

#### Methods

When writing code, it's quite common to find yourself writing the same thing over and over again. For example, let's look at a program that asks the user to specify their name and birthday.

```ruby
require 'date'

print 'What is your name? '
name = gets

print 'What year were you born (yyyy)? '
year = gets

print 'What month were you born (1-12)? '
month = gets

print 'What day were you born (1-31)? '
day = gets

birthday = Date.new(year.to_i, month.to_i, day.to_i)
total_days = (Date.today - birthday).to_i

puts "Hello #{name}, you were born #{total_days} days ago."
```

For every question we ask we follow the same two-step procedure: prompt the user with some text and then read their input off the command line. It would be nice if we had some way of saving this procedure so we could use it over and over again without having to type everything out. This is where **methods** can save the day!

```ruby
require 'date'

def prompt(text)
  print text
  gets
end

name = prompt('What is your name? ')
year = prompt('What year were you born (yyyy)? ')
month = prompt('What month were you born (1-12)? ')
day = prompt('What day were you born (1-31)? ')

birthday = Date.new(year.to_i, month.to_i, day.to_i)
total_days = (Date.today - birthday).to_i

puts "Hello #{name}, you were born #{total_days} days ago."
```

Here we've defined a method named `prompt` that takes a single **argument**. Because it is defined with an argument, we can pass in a string of text for us to send to the `puts` call. By defining this method, we're essentially telling the Ruby interpreter that we have this chunk of code we want to run at some point in the future and we're going to call it `prompt` so we have a way to reference it again. So when the Ruby interpreter sees the line

```ruby
name = prompt('What is your name? ')
```

it knows look for a method named `prompt` and run the block of code inside that method. Every time you reference this method, we say that the method is **called** or **invoked**.

#### Parameters

The particular message we pass in to the prompt method is called an __argument__ and the placeholder defined when we create the prompt method is called a __parameter__. In `prompt`, we require a single parameter named `text` which acts as a variable we can use in our method body. We don't know what the value of the parameter will be until the method is actually called with a particular argument.

Compare the following two examples:

```ruby
# Bad! Each method is of very limited use with lots of
# duplicated code.

def prompt_name
  print 'What is your name? '
  gets
end

def prompt_year
  print 'What year were you born (yyyy)? '
  gets
end

def prompt_month
  print 'What month were you born (1-12)? '
  gets
end

def prompt_day
  print 'What day were you born (1-31)? '
  gets
end
```

vs

```ruby
# Good, provides a procedure that can work on
# lots of different inputs.

def prompt(text)
  print text
  gets
end
```

Here we can see the benefit that using a parameter provides. We could write out each prompt as its own method, but by extracting the common procedure (print out some text, read in some input) we can make the method much more flexible and useful (and we reduce the number of methods we have to write).

This follows the **DRY** Principle in software development, which stands for **Don't Repeat Yourself*** and is adhered to quite strictly in Rails. Using a single method for `prompt` makes our codebase easier to maintain if we ever wanted to make modifications or track down an issue regarding prompting users for input.

There is actually a subtle bug in the code example above. If we were to run the program, we'd get the following:

```no-highlight
What is your name? Adam
What year were you born (yyyy)? 1985
What month were you born (1-12)? 4
What day of the month were you born (1-31)? 4
Hello Adam
, you were born 10346 days ago.
```

When I typed in my name and hit enter, the value that was saved in the `name` variable was actually `Adam\n` rather than `Adam` which caused the extra newline to appear at the end. `\n` indicates a newline character, and it is often undesirable when it comes to dealing with user input.

We can adjust our `prompt` method to strip off the newline before returning it to the caller.

```ruby
def prompt(text)
  print text
  gets.chomp
end
```

Using the method [`.chomp`][1] on the String class will strip off the newline character at the end before returning it. This demonstrates the benefits of methods and of staying DRY. We were able to fix this bug with only one change since our code for prompting the user is limited to the `prompt` method. If we were calling `gets` repeatedly through the program, we'd have to track them all down and change each one.

#### Arguments vs. Parameters

The terms __argument__ and __parameter__ come up quite a bit when talking about methods and have similar but slightly different meanings. When defining a method, we include method parameters in the method definition.

```ruby
def prompt(text)
  print text
  gets.chomp
end
```

Here `text` is our parameter and we can refer to it within our method body. When we're calling a method, we provide _arguments_ in our invocation.

```ruby
name = prompt('What is your name? ')
year = prompt('What year were you born (yyyy)? ')
```

In the first call to `prompt` we are providing the argument `'What is your name? '` which gets assigned to the parameter `text` in the method body. The second call to `prompt` passes in the argument `'What year were you born (yyyy)? '`. So the real difference between parameters and arguments is whether we are referring to the method definition itself (parameters) or whether we're invoking the method with our own values (arguments). While this is the technical difference between the two, they are often used interchangeably.


#### Optional Parameters

Sometimes, we want to allow parameters that have reasonable defaults. For example, if we wanted the option in our method to get input on a new line, we might add an optional parameter like we've done below.

```ruby
def prompt(text, input_on_newline = false)
  if input_on_newline
    puts text
  else
    print text
  end
  gets.chomp
end
```

If we invoke the function without a second argument, it will default to the value `false` as indicated in the method definition.

```ruby
prompt('What is your favorite color?') # input_on_newline will be false here
prompt('What is your favorite color?', true) # input_on_newline will be true here
```

We say that the `prompt` method now takes two arguments, where one is optional.

[1]: http://ruby-doc.org/core-2.0/String.html#method-i-chomp

### Why This Matters

#### Methods keep things DRY

Methods provide us with an initial layer of organization in our programs. By defining methods, we are able to eliminate duplication in our code through a process known as **encapsulation**. We're isolating and naming behavior so we can reuse it throughout our program.
