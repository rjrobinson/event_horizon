Create a program that will guess a randomly picked number between 1 and some max value. Use the following code to test your implementation:

```ruby
MAX_VALUE = 300000000
MAX_TRIES = Math.log2(MAX_VALUE).ceil

hidden = rand(MAX_VALUE) + 1
checks_called = 0

define_method :check do |guess|
  checks_called += 1

  if checks_called > MAX_TRIES + 1
    raise "check called too many times"
  end

  if guess > hidden
    1
  elsif guess < hidden
    -1
  else
    0
  end
end

def guess_number(min, max)
  # You can call the `check` method with a number to see if it
  # is the hidden value.
  #
  # If the guess is correct, it will return 0.
  # If the guess is too high, it will return 1.
  # If the guess is too low, it will return -1.
  #
  # If you call `check` too many times, the program will crash.
  #
  # e.g. if the hidden number is 43592, then
  #
  # check(50000) # => 1
  # check(40000) # => -1
  # check(43592) # => 0
  #
  # When you've figured out what the hidden number is, return it
  # from this method.

  #######################
  # YOUR CODE GOES HERE #
  #######################
end

guess = guess_number(1, MAX_VALUE)

if guess == hidden
  puts "Guessed correctly!"
  exit 0
else
  puts "Invalid guess."
  exit 1
end
```

The goal is to implement the `guess_number` method without changing any other code in the file. You can call the `check` method to determine whether your guess is correct or not, but there is a limit to how many times you can use `check`. Try to think of the most optimal way to determine what the hidden number is using the least amount of guesses (hint: this [algorithm](http://en.wikipedia.org/wiki/Binary_search_algorithm) may come in handy).
