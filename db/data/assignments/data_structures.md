---
title: Data Structures
slug: data-structures
type: review
---

In this unit you'll review Ruby's data structures, primarily the Array and Hash and their applications.

### Learning Goals

* Disambiguate between an Array and a Hash
* Apply an Array or a Hash where appropriate when building solutions

### Resources

* [RubyDoc: Array][1]
* [RubyDoc: Hash][2]

### Implementation Details

#### Data Structures

A large part of software development deals with managing and manipulating information. For us to work with information, we need to store it as data somehow. How we store it has a large impact on how our applications behave in terms of efficiency, readability, and size.

Consider a search engine like Google that stores petabytes of information yet can query it in fractions of a second. Or how a social network like Facebook can track who's connected to whom among its many millions of users. These types of problems rely heavily on appropriate choice of data structures to ensure that they can store and retrieve information in an efficient way.

For smaller-scale problems, choosing the right data structures is still important as it helps to make our lives easier. Ruby comes with two extremely useful data structures as part of the core language: [Array][1] and [Hash][2]. For a majority of problems we encounter, we can effectively model our data using these two classes.

#### Array

Arrays are used when we need to store a collection of data. Sometimes we want to use an array to store an unknown quantity of something (e.g. the number of results from a search query or a list of a user's tweets). Arrays also preserve the order of elements, so we can also use an array to group related information together (e.g. storing a user's name, email, and address in different elements of a single array), although we will later discover how a hash might be a better solution for that.

We can access individual elements in an array using their position as an index:

```no-highlight
2.0.0p353 :001 > a = [42, 3.14159, 'hodor!']
 => [42, 3.14159, "hodor!"]

2.0.0p353 :002 > a[0]
 => 42

2.0.0p353 :003 > a[1]
 => 3.14159

2.0.0p353 :004 > a[2]
 => "hodor!"

2.0.0p353 :005 > a[3]
 => nil
```

We can iterate over the entire collection using `.each`:

```ruby
[42, 3.14159, 'hodor!'].each do |element|
  puts element
end

# Outputs:
# 42
# 3.14159
# 'hodor!'
```

In addition to accessing and iterating over the elements, the Array class comes with a large number of very useful methods for querying and transforming its elements (which can be found [here][1]).

#### Hash

Hashes (sometimes called maps or associative arrays) contain a set of key-value pairs. For arrays, when we wanted to access an element we needed to supply its position within the array (its index). For a hash, we use the key as the index to access an element. Consider the example below.

```ruby
characters = [
  ["Tyrion Lannister", "House Lannister"],
  ["Jon Snow", "Night's Watch"],
  ["Hodor", "House Stark"],
  ["Stannis Baratheon", "House Baratheon"],
  ["Theon Greyjoy", "House Greyjoy"]
]

hodor = nil

characters.each do |char|
  if char[0] == "Hodor"
    hodor = char
    break
  end
end

puts "Hodor is affiliated with #{hodor[1]}"
```

Here we've created a program that links our favorite Game of Thrones characters with the house they represent as nested arrays in the `characters` variable. If we wanted to access the house for a character named `'Hodor'`, we'd have to iterate through the array until we found a match. This isn't too bad for an array with five elements, but we'd start to notice the drag if we had to run through several thousand elements to get the one we want.

Instead we can use a hash to map the character's name (key) to their house (value). Our code might look something like:

```ruby
characters = {
  "Tyrion Lannister" => "House Lannister",
  "Jon Snow" => "Night's Watch",
  "Hodor" => "House Stark",
  "Stannis Baratheon" => "House Baratheon",
  "Theon Greyjoy" => "House Greyjoy"
}

hodors_house = characters["Hodor"]

puts "Hodor is affiliated with #{hodors_house}"
```

The curly braces `{..}` can be used to define a hash in Ruby. Instead of having single elements separated by commas as we did for an Array, we define our list of key-value pairs separated by commas in the format of `key => value` (e.g. `"Jon Snow" => "Night's Watch"` maps Jon to the Night's Watch). We call the `=>` operator a **hashrocket**.

When we need to access a certain value, we can retrieve it efficiently as long as we know the key. In our example, we defined our hash to use the character's name as the key and their house as the value, so we could efficiently look up a character's house as long as we had their name (e.g. `characters["Hodor"]`). This is in contrast to the array example where we had to iterate over the elements to find the one that matched. As our array grew, the time it would have taken to find our match would get longer and longer. The lookup time for an element in a hash stays relatively constant regardless of the number of key-value pairs.

#### Big-O Notation

We briefly touched upon how the size of our data structure affects certain operations (e.g. the time it takes to iterate through an array grows as the size of the array grows). This is more formally described by something known as **Big-O Notation** which provides estimates of how efficiently operations will scale. Algorithm analysis is outside the scope of this course but you can find more information [here][4] if you're interested.

### Rules to Follow

#### Always Consider the Use Case

The choice of data structure is largely dependent on how we plan to use it. Before choosing one or the other, it is prudent to briefly outline our program to see where we'll be updating and accessing our data.

### Why This is Important

Knowing the strengths of both arrays and hashes will make solving certain problems significantly easier when we can utilize the appropriate data structure.

[1]: http://ruby-doc.org/core-2.0/Array.html
[2]: http://ruby-doc.org/core-2.0/Hash.html
[3]: https://en.wikipedia.org/wiki/Dynamic_array
[4]: http://en.wikipedia.org/wiki/Big_O_notation
