---
title: Compound Data Structures
slug: compound-data-structures
type: review
---

In this review assignment, you'll be introduced to **compound data structures** created by nesting Ruby arrays and hashes within each other.

### Learning Goals

* Create compound data structures by combining arrays and hashes
* Parse JSON data as a Ruby data structure

### Resources

* [Wikipedia: JSON][1]

### Implementation Details

Arrays are useful for storing collections of items. These collections can be of an arbitrary size and are able to grow as needed. Hashes are useful for defining named attributes via key-value pairs when we want to group related information. We can nest these data structures within each other to create a **compound data structure**.

```ruby
favorite_movies = [
  { title: 'The Big Lebowski', year_released: 1998, director: 'Joel Coen', imdb_rating: 8.2 },
  { title: 'The Shining', year_released: 1980, director: 'Stanley Kubrick', imdb_rating: 8.5 },
  { title: 'Troll 2', year_released: 1990, directory: 'Claudio Fragasso', imdb_rating: 2.5 }
]
```

Here we nested three hashes describing some movies within an array. We can iterate over this array to print out the name and rating of each movie.

```ruby
favorite_movies.each do |movie|
  puts "Title: #{movie[:title]}, Rating: #{movie[:imdb_rating]}"
end
```

The `each` method is taking each element of the array and storing it in the `movie` variable. Since each element is actually a hash, we can refer to `movie[:title]` and `movie[:imdb_rating]` to access the value associated with those keys.

{% quick_challenge %}
Using the array of hashes above, output the titles, along with their year to achieve the following output.

```no-highlight
1998: The Big Lebowski
1980: The Shining
1990: Troll 2
```

{% question 'sort-gist' %}
{% endquick_challenge %}

We can take this a step further if we wanted to include more information about our movies. Consider adding a list of actors to a movie:

```ruby
movie = {
  title: 'The Royal Tenenbaums',
  year_released: 2001,
  director: 'Wes Anderson',
  cast: [
    'Gene Hackman',
    'Anjelica Huston',
    'Ben Stiller',
    'Gwyneth Paltrow',
    'Luke Wilson',
    'Owen Wilson'
    # ...
  ]
}
```

Now our hash is mapping an array containing the names of actors and actresses to the `:cast` key. Anytime we have an attribute that could store a varying number of elements an array should be the data type of choice. Every movie can have a different number of actors and actresses so we need something that can accommodate that.

What if we want to store information about the characters that each actor or actress portrays? We can keep nesting as much as we like as long as it makes sense to structure our data in such a way:

```ruby
movie = {
  title: 'The Nutty Professor',
  cast: [
    {
      name: 'Eddie Murphy',
      characters: [
        'Sherman Klump',
        'Buddy Love',
        'Lance Perkins',
        'Papa Klump',
        'Mama Klump',
        'Grandma Klump',
        'Ernie Klump'
      ]
    },
    {
      name: 'Jada Pinkett Smith',
      characters: [
        'Carla Purty'
      ]
    }
  ]
}
```

Here we have a hash (`movie`) that is nesting an array of hashes (`movie[:cast]`), each of which also contains its own array (`movie[:cast][0][:characters]`).

There isn't necessary a limit to how deep we can nest our data structures except our own good judgement. At some point we need to consider what data is relevant to our needs and design our data structures accordingly.

### JSON

The previous examples showed how we could structure our data using arrays and hashes in Ruby. Consider the following snippet:

```JSON
{
  "movies": [{
    "id": "770687943",
    "title": "Harry Potter and the Deathly Hallows - Part 2",
    "year": 2011,
    "mpaa_rating": "PG-13",
    "runtime": 130,
    "critics_consensus": "Thrilling, powerfully acted, and visually dazzling, Deathly Hallows Part II brings the Harry Potter franchise to a satisfying -- and suitably magical -- conclusion.",
    "release_dates": {"theater": "2011-07-15"},
    "ratings": {
      "critics_rating": "Certified Fresh",
      "critics_score": 97,
      "audience_rating": "Upright",
      "audience_score": 93
    },
    "abridged_cast": [
      {
        "name": "Daniel Radcliffe",
        "characters": ["Harry Potter"]
      },
      {
        "name": "Rupert Grint",
        "characters": [
          "Ron Weasley",
          "Ron Wesley"
        ]
      },
      {
        "name": "Emma Watson",
        "characters": ["Hermione Granger"]
      },
      {
        "name": "Helena Bonham Carter",
        "characters": ["Bellatrix Lestrange"]
      },
      {
        "name": "Ralph Fiennes",
        "characters": ["Lord Voldemort"]
      }
    ],
    "alternate_ids": {"imdb": "1201607"}
  }]
}
```

This is a sample of data returned from an API call to Rotten Tomatoes. It's not Ruby code but rather [JSON][1], a data format used frequently when communicating between applications. But we can see there are many similarities between this JSON data and the Ruby code we defined in the earlier examples. JSON has a few available data types including arrays (using the `[..]` syntax) and objects (which behave similarly to hashes and use the same `{..}` syntax).

In fact, we can convert this JSON directly into Ruby data structures using the [JSON][2] module. If we saved the above JSON in a file named `tomatoes.json` we could then run:

```ruby
require 'json'

# Read the contents of the tomatoes.json file into a string
json_string = IO.read('tomatoes.json')

# Convert the JSON string into Ruby data structures
movies = JSON.parse(json_string)

puts movies.class
# => Hash

puts movies["movies"][0]["title"]
# => "Harry Potter and the Deathly Hallows - Part 2"
```

JSON is a very important part of the web and being able to easily manipulate JSON data with Ruby data structures is a powerful feature of the language. We'll encounter JSON more when working with external APIs as well as defining our own APIs for others to consume.

### Rules to Follow

#### Only Include Whats Relevant

In the previous examples, we kept expanding our movie hash to include more information. Before going on to create deeply nested data structures, consider whether that information is relevant to the problem at hand and even needed. The less bloated our data, the easier it is to identify what's important.

#### A Hierarchy is Not Always the Best Choice

The data we defined followed a hierarchal format: we started with a movie at the top level which had many actors and actresses nested within it. We could have also included information on each actor or actress:

```ruby
movies = [
  {
    name: 'The Usual Suspects',
    cast: [
      { name: 'Kevin Spacey', born: '26 July 1959' }
      # ...
    ]
  },
  {
    name: 'American Beauty',
    cast: [
      { name: 'Kevin Spacey', born: '26 July 1959' }
      # ...
    ]
  }
  # ...
]
```

Here we've included the actor's or actress' birthday, but we can see that we're duplicating information when we have the same actor referred to in multiple locations. This redundancy is unavoidable when we are using a strict hierarchy. We'll talk about different ways to structure our data to avoid this duplication when we deal with relational databases.

### Why This is Important

Combining data structures lets us model our information much more effectively than if we had to choose any one structure. Understanding how arrays and hashes can work together is an important part of understanding how to structure our data.

[1]:http://en.wikipedia.org/wiki/JSON
[2]:http://www.ruby-doc.org/stdlib-2.0/libdoc/json/rdoc/JSON.html
