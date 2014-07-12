---
title: Hashes
slug: hashes
type: review
---

In this assignment, you'll be introduced to the Ruby **Hash** in more detail.

### Learning Goals

* Use a Hash to group related attributes
* Use a Hash to store arbitrary key-value pairs

### Resources

* [Rubydoc: Hash][3]
* [Wikipedia: Associative Arrays][2]

### Implementation Details

Sometimes, we want a little more structure than a simple ordered list of things provides. We can access elements in an array by their position, but sometimes the position doesn't really help us much. Consider how we previously used an array to store individual transactions:

```ruby
trans = [2000.00, "payday!", Date.new(2013, 6, 26)],

puts trans[0] # Outputs 2000.00, the amount
puts trans[1] # Outputs "payday!", the description
puts trans[2] # Outputs 2013-06-26, the date
```

This works OK but it requires us to know that the amount is in the first position and the description comes next. The expression `trans[0]` doesn't really convey that we are accessing an amount. It's also inflexible if we ever decide to rearrange the elements or insert new elements within the array; we'd have to change all of our indices.

A more suitable data structure for this type of information would be a **hash**. Hashes contain a list of key-value pairs. The values that we want to store are mapped to a unique key within the hash so that we have a way to reference that value again. We could rewrite our previous code sample using a hash:

```ruby
trans = { "amount" => 2000.00, "description" => "payday!", "date" => Date.new(2013, 6, 26) }

puts trans["amount"]      # Outputs 2000.00, the amount
puts trans["description"] # Outputs "payday!", the description
puts trans["date"]        # Outputs 2013-06-26, the date
```

On the first line, we define or construct our hash using the `{..}` syntax (we could have also used `trans = Hash.new`). We supply our key-value pairs within the curly braces. The snippet `"amount" => 2000.00` is saying that we want to take the value `2000.00` and map it to the key `"amount"`. This lets us use the syntax `trans["amount"]` to access the value of `2000.00` later. If we compare the two code samples, which one is clearer to read: `trans[0]` or `trans["amount"]`? The ability to use descriptive keys is one of the many benefits of using a hash.

### Symbols

In the previous example we had a hash where we mapped a string (`"amount"`) to a value (`2000.00`). In Ruby there is another data type commonly used with hashes known as a **symbol**. A symbol is very similar to a string except we use a slightly different syntax: instead of `'name'` we use `:name`. The primary difference between a symbol and a string is that a symbol is _immutable_, meaning that once we define it we can't change it. For example, this is valid Ruby:

```ruby
a = "foo"
a.upcase! # Mutates the string
puts a    # Outputs "FOO"
```

We're able to change the string `"foo"` in place using the `upcase!` method. If we try doing that with a symbol, we'll get an error:

```ruby
b = :foo
b.upcase!  # Error! No method .upcase! defined
```

This immutability makes it a bit more efficient to use symbols over strings so you'll often see them used as keys within hashes instead of strings. Try using a symbol in the example below.

```ruby
trans = { :amount => 2000.00, :description => "payday!", :date => Date.new(2013, 6, 26) }

puts trans[:amount]      # Outputs 2000.00, the amount
puts trans[:description] # Outputs "payday!", the description
puts trans[:date]        # Outputs 2013-06-26, the date
```

Note that there is a difference between the symbol and the string. Try the following example.

```ruby
trans = { :amount => 2000.00, :description => "payday!", :date => Date.new(2013, 6, 26) }
trans[:amount]
trans["amount"]
```

Starting in Ruby 1.9, there is slightly more compact (and preferred) way for creating a Hash by removing the `=>` symbol (aka hashrocket) and placing the colon after the symbol name. We can modify the example above to reflect this new syntax.

```ruby
trans = { amount: 2000.00, description: "payday!", date: Date.new(2013, 6, 26) }

puts trans[:amount]      # Outputs 2000.00, the amount
puts trans[:description] # Outputs "payday!", the description
puts trans[:date]        # Outputs 2013-06-26, the date
```

These examples are equivalent but the second one is slightly more compact. Note this only works when using a symbol as the key.

### Counting Words

So far, we've used hashes as a way of assigning more meaningful names in our data structures, but they are useful in many other scenarios as well. Consider trying to count the number of occurrences of each word in a string:

```ruby
# Initialize our hash with nothing in it.
counts = {}

# Splits a string into an array of words.
input = 'the brown fox jumped over the lazy dog'
words = input.split # ["the", "brown", "fox", "jumped", "over", "the", "lazy", "dog"]

# Loop through each word found in the string...
words.each do |word|

  # If the word hasn't been seen before, initialize the count to zero.
  unless counts.has_key?(word)
    counts[word] = 0
  end

  # Increment the count for the word by one.
  counts[word] += 1
end

puts counts.inspect
```

In this example, we're using a hash to count the occurrences of each word where the keys are the words and the values are the counts. When we start, we have `counts = {}` since we don't know what words to include yet. We take our input (a string) and split it into an array of words using the `split` method. Then for each word, we're checking to see whether we've already added it to the hash (using the `has_key?` method) and if not, we initialize it to zero. The line `counts[word] += 1` is what is actually doing the counting; if we remember that this line is equivalent to `counts[word] = counts[word] + 1`, we're taking the previous count, incrementing it by one, and saving it back to the same location in the `counts` hash.

When we get to the end, our `counts` hash should look something like this:

```ruby
{"the"=>2, "brown"=>1, "fox"=>1, "jumped"=>1, "over"=>1, "lazy"=>1, "dog"=>1}
```

In this case, we didn't know what keys we'd need but were able to add them dynamically as we processed each word. We can add a new key-value pair to an existing hash just by assigning to it: `counts[word] = 0` will create the pair `word => 0` if it doesn't exist yet.

### Iterating over Hashes

Just like Arrays, we can iterate over our hash using the `each` method. Try the example below.

```ruby
word_counts = {
  "the" => 2, "brown" => 1, "fox" => 1,
  "jumped" => 1, "over" => 1, "lazy" => 1, "dog" => 1
}

word_counts.each do |word, count|
  puts "#{word} appeared #{count} time(s)."
end
```

We pass in two parameters to our code block (`word` and `count`) which will be populated with the key and value for each pair in the hash. The pairs will appear in the order in which they were inserted into the hash.

The `Hash` class also includes the **Enumerable** module that we saw when working with arrays. Any method defined in Enumerable can be used on a hash. For example, we might want to find any words that appear more than once in a string. Using our `word_counts` hash above, we might iterate over the hash using `each`. Try the following example.

```ruby
word_counts = {
  "the" => 2, "brown" => 1, "fox" => 1,
  "jumped" => 1, "over" => 1, "lazy" => 1, "dog" => 1
}

common_words = {}

word_counts.each do |word, count|
  if count > 1
    common_words[word] = count
  end
end

puts common_words.inspect # Outputs {"the"=>2}
```

### Rules to Follow

#### Choose the right key

Hashes are not limited to using just strings or symbols as keys: any Ruby object can be used as a key since all objects implement the `hash` method. Consider how you plan on accessing your data and use that as a guide for determining what to use as a key and what is the value.

### Why This is Important

The Hash is one of the core data structures in Ruby. As we encounter new programming problems, we should always keep an eye open for situations where a hash will help us organize our data more efficiently.

[2]: http://en.wikipedia.org/wiki/Associative_array
[3]: http://www.ruby-doc.org/core-1.9.3/Hash.html
