---
title: Arrays
slug: arrays
type: review
---

In this review assignment you'll be introduced to Ruby Arrays. An array is an ordered list of values. An array can contain any type of data, such as strings, integers, or even other arrays.

### Learning Goals

* Instantiate arrays
* Append values to arrays
* Read arrays and identify specific elements of an array
* Begin to iterate through arrays using a `for..in..end` loop

### Implementation Details

#### Collections of Values

So far we've used a few different types to represent data in our program: ints, floats, strings, and dates. All of these types represent a single piece of information, yet a lot of problems deal with collections of values. What if we wanted to write a program that tracked our finances:

```ruby
balance = 4212.19

rent = -1250.00
electric = -56.31
gas = -23.10
groceries = -231.15
paycheck = 1239.84

balance = balance + rent + electric + gas + groceries + paycheck

puts "Final balance = #{balance}"
```

Here we store our initial balance and create a new variable for each transaction, positive floats for income and negative floats for expenses. Adding up all of these variables will give us our final balance.

As our list of transactions grows, it will become more and more tedious to define a new variable for each one and add them all up at the end. Instead, we can use an __array__ to store an arbitrary number of transactions and then apply each of them to our initial balance:

```ruby
balance = 4212.19
transactions = [-1250.00, -56.31, -23.10, -231.15, 1239.84]

for trans in transactions do
  balance += trans
end

puts "Final balance = #{balance}"
```

The `transactions` variable stores an array of floats containing all of the values we previously had listed individually. The `for` loop in this example takes the array and runs the given block of code once for each element of the array, storing the value in `trans`.

```no-highlight
for <element> in <array> do
  # This runs once per element...
end
```

This is a very flexible way to deal with arbitrary amounts of data. In our previous example we knew ahead of time how many transactions we were processing, but now our code can to handle any number of values:

```ruby
def read_transactions
  # Get a list of transactions from somewhere...
  # e.g. read from a file, download from bank's website, etc.
end

balance = 4212.19
transactions = read_transactions

for trans in transactions do
  balance += trans
end

puts "Final balance = #{balance}"
```

Here we are reading our transactions from an outside source where we won't know ahead of time how many values we'll get back. This flexibility is one of the major benefits of using arrays. The code to handle five transactions is the same code that will handle ten, fifty, or ten thousand transactions.

## Creating and Indexing Arrays

The previous examples showed one way of creating an array using the `[...]` syntax. We could also create an array using `Array.new`:

```no-highlight
2.0.0p353 :001 > a = []
 => []

2.0.0p353 :002 > b = Array.new
 => []
```

Both methods produce an empty array represented by `[]`. An empty array is not that interesting, so lets add some elements to it in `irb`:

```no-highlight
2.0.0p353 :001 > a = []
 => []

2.0.0p353 :002 > a << "foo"
 => ["foo"]

2.0.0p353 :003 > a << "bar"
 => ["foo", "bar"]
```

Here we use `<<` to append a new value onto the end of the array we just created. After each append step, we see that the new array is printed out on the next line with the element we added on the end.

So we've created an array and added some data, how can we access it again?

```no-highlight
2.0.0p353 :001 > b = ["foo", "bar", "baz"]
=> ["foo", "bar", "baz"]

2.0.0p353 :002 > b[0]
=> "foo"

2.0.0p353 :003 > b[1]
=> "bar"

2.0.0p353 :004 > b[2]
=> "baz"

2.0.0p353 :005 > b[3]
 => nil
```

The square brackets we used to create the array can also be used to access individual elements. It looks a bit strange since when we gave the index `2`, we got the third element, but we're actually specifying the offset from the start of the array, i.e. give me the element that is `2` elements after the start of the list, which is the third one. This is called __zero-based indexing__ and has several advantages over __one-based indexing__ (which can be found [here][1] for the curious).

The last example also reveals what happens if we try to access an element that is beyond the length of our array (`b[3]`). Ruby simply returns `nil` indicating that the value you're trying to access does not exist.

#### Going the other way

We can get the first element of an array using `b[0]`, but Ruby also provides a convenient way for getting the last element:

> ```ruby
> b = ["foo", "bar", "baz"]
> b[-1] # "baz"
> b[-2] # "bar"
> b[-3] # "foo"
> b[-4] # nil
> ```

Using negative indices tells Ruby to start looking at the end of the array and work your way backwards.

### Mix and Match

In Ruby, arrays can store a mix of different values. Our previous arrays contained only strings, but that doesn't prevent us from adding other types of values.

```no-highlight
2.0.0p353 :001 > c = []
 => []

2.0.0p353 :002 > c << "foo"
 => ["foo"]

2.0.0p353 :003 > c << 42
 => ["foo", 42]

2.0.0p353 :004 > c << 3.14159
 => ["foo", 42, 3.14159]
```

Ruby isn't picky about the data types and lets you mix and match in a single array. This is especially handy if we wanted to use an array as a way of grouping information together.

```ruby
require 'date'

trans = [-1250.00, "july's rent", Date.new(2013, 7, 1)]

puts "Amount: #{trans[0]}"
puts "Description: #{trans[1]}"
puts "Date: #{trans[2]}"
```

In this example we use an array to store several pieces of information about a single transaction and are able to extract the relevant bits we need using indexing. In fact, we can combine this with another array to store all of our transactions:

```ruby
require 'date'

all_transactions = [
  [2000.00, "payday!", Date.new(2013, 6, 26)],
  [-1250.00, "july's rent", Date.new(2013, 7, 1)],
  [-57.12, "electric", Date.new(2013, 7, 3)],
  [-7.38, "lunch at metro", Date.new(2013, 7, 4)]
]

balance = 0.0

for trans in all_transactions do
  balance += trans[0]

  puts "Amount: #{trans[0]}"
  puts "Description: #{trans[1]}"
  puts "Date: #{trans[2]}"
  puts "Balance: #{balance}"
end
```

Arrays can store just about anything, including other arrays. We'll use this concept more when we talk about reading and writing from files in a later unit.

#### Other Instance Methods to Manipulate Arrays

Ruby core defines a set of additional methods we can use on arrays to manipulate them. These **instance methods** allow for added behavior.

##### unshift

`unshift` gives us the ability to prepend to an array:

```ruby
letters = ['b', 'c', 'd']
letters.unshift('a')
# => ['a', 'b', 'c', 'd']
```

##### pop

`pop` removes the last element from the array:

```ruby
letters = ['a', 'b', 'c']
letters.pop
# => returns 'c' and removes it from the letters array
```

##### insert

`insert` adds an element at a specified position:

```ruby
letters = ['a', 'b', 'c']
letters.insert(1, 'x')
# => ["a", "x", "b", "c"]
```

#### Other instance methods

You should take a moment to explore what [methods are available](http://ruby-doc.org/core-2.0/Array.html) to you to help with manipulating arrays. Ruby core provides us with a wealth of options when it comes to working with objects like strings, numbers, and arrays.

### Why This Matters

#### Manipulating Ordered Collections of Objects is a Common Programmer's Activity

As developers, we often have to deal with a collection of objects. In a Rails context, we might loop through a collection of database records to list them out on an HTML web page. In a model context, we might append a comment to the comments collection of an article. Arrays provide us with a basic framework for reading from and manipulating ordered lists of objects.

[1]: http://en.wikipedia.org/wiki/Zero-based_numbering
