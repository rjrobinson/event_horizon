---
title: Variables
slug: variables
type: review
---

In this review assignment, you'll be introduced to **variables** which are an essential part of Ruby for managing your data and programs.

### Learning Goals

* Use the assignment operator to define a variable
* Determine the difference between assignment and equality
* Use shorthand assignment

### Resources

* [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)

### Implementation Details

#### What is a variable?

In programming languages, a variable is a way of giving some value a name. Assuming we have some piece of data, whether it is someone's name ("Bob"), their age (37), or their height in [beard-seconds][1] (421432958.12), we can save it in a variable so that we're able to easily reference it later.

```ruby
name = "Bob"
age = 37
height_in_beard_seconds = 421432958.12
```

Why would we want to do this? Well, for starters it's a lot more readable when the data we're working with are assigned intuitive names. Which of the following code snippets is easier to read?

```ruby
if 37 >= 21
  puts "One Sloe Gin Fizz coming right up!"
else
  puts "Here's your shirley temple..."
end
```

or

```ruby
DRINKING_AGE = 21

if age >= DRINKING_AGE
  puts "One Sloe Gin Fizz coming right up!"
else
  puts "Here's your shirley temple..."
end
```

Both examples are functionally the same and both are working with the same values, but the second example assigns meaningful names to the values which help clarify the developer's intent. If another developer were to look at the first example, they'd be scratching their heads trying to figure out what those numbers represent while it only takes a glance of the second example to understand what is happening.

More importantly though, variables can be used to represent unknowns within a program. When writing our code, it should be flexible and generic enough to handle a range of input values. For example, if we wanted to calculate someone's annual wages given their hourly rate and hours worked, we could write something like:

```ruby
WEEKS_PER_YEAR = 52

hourly_rate = 12.50
hours_per_week = 40

annual_wages = hourly_rate * hours_per_week * WEEKS_PER_YEAR
puts "annual wages: #{annual_wages}"
```

This will return the annual wages for someone that works 40 hours a week at $12.50/hour. But what if they work 30 hours? Well we can just change `hours_per_week = 30` and re-run the code. In fact, we don't need to know the actual values yet as long as we have a way to reference them:

```ruby
WEEKS_PER_YEAR = 52

# Prompt the user to enter their rate and hours
print "hourly rate: "
hourly_rate = gets.to_f

print "hours per week: "
hours_per_week = gets.to_f

annual_wages = hourly_rate * hours_per_week * WEEKS_PER_YEAR
puts "annual wages: #{annual_wages}"
```

Here we are reading the user's hourly wages and hours per week from their input which makes this code much more flexible. This is a powerful form of abstraction that we'll talk more about when we discuss defining our own methods in a later unit.

#### What's with the caps?

In the previous examples we used the `DRINKING_AGE` variable to help clarify what the value of 21 was. The reason we used all caps is because this value is effectively constant for our program, and the convention in Ruby is to use all caps for variables that should not change. This is only a convention though and Ruby won't stop you from reassigning it (e.g. `DRINKING_AGE = 18` for the rest of the world), but this is considered a bad practice and Ruby will warn you when you do so. Because the value of DRINKING_AGE will not change during the life of our program, we refer to it as a **constant**.

#### Variable Assignment

In Ruby, creating a variable is easy. Simply pick the name you want to use and the value you want to save and use Ruby's assignment operator `=`.

```ruby
name = "Bogie"
```

The value `"Bogie"` is a string that is being assigned to the variable `name`. The order is important here: the assignment operator `=` takes the value on the right and assigns it to the variable name on the left. It would be considered invalid to perform the operation below.

```ruby
"Bogie" = name # Syntax Error! "Bogie" is not a valid variable name
```

This is because it would try taking the value of `name` and assigning it to the variable name `"Bogie"`, which is not a valid variable.

#### What's in a name?

When coming up with the name for your variable, the convention in Ruby is to use all lowercase characters and numbers with underscores separating the words (unless defining a constant, in which case you should use all caps). You also can't use any of the keywords from the Ruby language as variable names (there is a list of them [here][2]). Nor can you start a variable name with a number, for example `1st_variable` is an invalid variable name.

Once a variable is assigned some value, it can be used in later parts of the program as a drop-in replacement for the value.

```ruby
name = "Bogie"

puts "Hi #{name}!" # Prints out "Hi Bogie!"
puts "Bye #{name}!" # Prints out "Bye Bogie!"
```

Did you ever do [MadLibs](http://en.wikipedia.org/wiki/Mad_Libs) when you were younger? Think of assigning your variables as if you were filling in the blanks of a MadLib.

This becomes especially handy when we reference that variable in multiple places. We only need to change the variable assignment in one spot and the program adjusts accordingly:

```ruby
name = "Gizmo"

puts "Hi #{name}!" # Prints out "Hi Gizmo!"
puts "Bye #{name}!" # Prints out "Bye Gizmo!"
```

This might not seem like much of benefit in the previous example, but as our codebase grows and we reference the same variable over and over, it is mighty convenient to be able to change all of the references in just one line.

#### Variable Reassignment

When a variable is assigned, that variable name now points to some value. At some point in the future you may want to change that variable to point to a new value:

```ruby
age = 28
my_birthday = Date.new(2013, 4, 4)

if Date.today == my_birthday
  puts "feliz cumpleaños!"
  age = age + 1
end
```

Here we start with `age = 28`, and if today is a very special day,  then age is reassigned to `age = 29` through the `age = age + 1` statement. This may look kind of weird but in Ruby `=` does not mean equals in the traditional, mathematical sense. It first determines the value on the right and then assigns it to the variable on the left, overwriting what was there if necessary.

```ruby
age = age + 1
age = 28 + 1
age = 29
```

The dynamic nature of variables is what often results in bugs or flaws in your program. A variable might take on an unexpected value through the life of your program. As you introduce functionality that relies on that value, you will get unexpected results. As software developers, we call this occurrence a **logic error**. This type of error is different from a **syntax error**.

#### What is a syntax error?

[Syntax errors](http://en.wikipedia.org/wiki/Syntax_error) are easier to spot than logic errors. Basically, these occur when the interpreter can't understand what you're trying to express in your code. For example, syntax errors are usually attributable to missing parentheses or end's to your block. The Ruby interpreter will generally give us good information in the **backtrace** as to how to fix it. When the interpreter encounters a syntax error, it tries to supply you with as much information as possible to fix the error.

Try the following:

```bash
touch syntax_error.rb
echo "1+1 = 2" > syntax_error.rb
ruby syntax_error.rb
```

Here we are creating and running an invalid ruby file. We know from what we've learned so far about variable assignment is that we must have a valid variable name on the left hand of the assignment operator.

```
syntax_error.rb:1: syntax error, unexpected '=', expecting $end
1+1 = 2
     ^
```

The above example is what typically happens when a syntax error is encountered by the ruby interpreter. It starts with the file where the error occurred and what line number of that file was last executed that caused the error. It also supplies an error message that tries to give us a hint as to what went wrong. Over time, you will get better at understanding these messages. What the example above is telling us is that the interpreter expected the line to terminate after `1+1`, and that the `=` (assignment operator) was unexpected.

#### What is a logic error?

[Logic errors](http://en.wikipedia.org/wiki/Logic_error) are often trickier. As developers, it's important to understand that the computer will always do what we tell it to do. Very often in our programs, we write code that we think functions a certain way that is different from what reality is.

We jest and say that the problem exists between keyboard and chair ([PEBKAC](https://en.wikipedia.org/wiki/User_error)). The problem is not with the interpreter, it is a problem that you've introduced to your code. Logic errors can be very time consuming to isolate and fix. Over time, you will learn to keep track of your variables and how they change throughout the life of your program. Writing simpler and clearer programs makes this process easier, resulting in fewer bugs.

#### Assignment vs. Equality

Since Ruby uses `=` to assign variables, what can we use when we actually want to check whether two values are equal (in the traditional mathematical sense)?

Ruby uses the `==` operator to check for equality. It was used in the previous example to check whether two dates were equal (`Date.today == my_birthday`) and returns `true` if they are equal or `false` otherwise.

#### Shorthand assignment

We used `age = age + 1` to increment the `age` variable and assign it back to itself. This comes up quite frequently in programming and in Ruby there is a shorthand syntax to accomplish the same operation.

```ruby
age += 1
```

The above example is the equivalent of `age = age + 1`. This isn't limited to addition and can be used with a variety of other operators (e.g. `age -= 1` if you somehow figured out how to go back in time).

### Ruby Data Types

So far in this review assignment, we've seen variables containing several different types of values. We stored age as an integer, height as a float, name as a string, and a birthday as a date. Ruby can usually figure out what data type to use when storing a value so you don't have to specify it, but if you ever want to know what type a variable is you can use the `.class` method on that variable.

```ruby
age = 28
age.class # Fixnum

height_in_inches = 70.3
height_in_inches.class # Float

name = "Gizmo"
name.class # String

birthday = Date.new(1985, 4, 4)
birthday.class # Date

empty = nil
empty.class # NilClass

data_type = String
data_type.class # Class
```

The first four variables contain values that we've worked with so far: Fixnum (Integer), Float, String, and Date. You don't need to know the details of these types yet but just be aware of their existence.

The last two examples are a little different. `nil` is used to represent the absence of a value, but even `nil` has a type of `NilClass`. In Ruby, everything has a type, and the last example shows that we could take the data type of another variable (`String`) and find out what the type of a type is (in this case, it is of type `Class`). Classes are a feature of object-oriented programming which we'll cover in more detail in a later assignment, but the takeaway is that everything in Ruby has a type!

#### Float?

The term Float comes from "Floating point" which is a way that real numbers are represented internally by your computer. A float has a limited number of bits it can use to represent the number so it has to choose how much precision is needed before and after the decimal point and in the exponent. The ability to "float" the decimal point to accommodate a wide range of values is where the name originates. You can find more information [here][3].

[1]: http://en.wikipedia.org/wiki/Beard-second#Beard-second
[2]: http://ruby-doc.org/docs/keywords/1.9/
[3]: http://en.wikipedia.org/wiki/Floating_point

### Rules to Follow

#### Use Descriptive Names For Your Variables

Variable names are purely for the developer, and not for the computer or interpreter. You should start to think about the code you write as a way to communicate with other developers. Try to use descriptive names for your variables so your teammates can easily understand what you're trying to do with your code.

Bad Example:

```ruby
i = 0
x = gets.chomp
y = 3

while i <  y
  puts "Hi #{x}!"
  i += 1
end
```

Better example:

```ruby
hello_count = 0
name = gets.chomp
max_hellos = 3

while hello_count < max_hellos
  puts "Hi #{name}!"
  hello_count += 1
end
```

We say that the latter example is more **expressive** because it uses better variable names to tell a story. You always want your code to be expressive. In other words, it should be easy for others to read.

#### Follow Ruby Conventions

Developers expect that you follow the conventions of the language that you use. This means that you use the same style and formatting from program to program. If you think of your code as a means to communicate with other developers, you want that communication to be as consistent as possible with what they would expect from a typical ruby program.  Refer to the [unofficial ruby style guide](https://github.com/bbatsov/ruby-style-guide) as a way to get started with adhering to acceptable ruby conventions.

### Why This is Important

#### Variables Make Your Source Code "Developer Friendly"

Especially as a budding developer, you will read more code than you write. For code to be readable, well-named variables must be used as a means to communicate your intent with your software.
