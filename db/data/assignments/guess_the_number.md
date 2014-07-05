---
title: Guess the Number
type: challenge
---

Create a game that picks a random number between 1 and some max value (e.g. 1000). The user should then be prompted to guess the number. If the user guesses correctly, they win the game and the program ends. If the guess is incorrect, respond with either "Too high" or "Too low" and prompt for input again.

## Example Usage

Here is what a sample run of the game should look like:

```no-highlight
$ ruby game.rb
Guess a number between 1 and 1000: 500
Too high, try again.

Guess a number between 1 and 1000: 250
Too high, try again.

Guess a number between 1 and 1000: 125
Too high, try again.

Guess a number between 1 and 1000: 67
Too high, try again.

Guess a number between 1 and 1000: 33
Too low, try again.

Guess a number between 1 and 1000: 50
Too low, try again.

Guess a number between 1 and 1000: 57
Congratulations, you guessed the number!
```

### Extra Credit: Guess The Number-Solver

If you've completed the game and are looking for something a bit more challenging, try writing a program that will guess what the hidden number is in a systematic way. Copy the following code to a new file called `solver.rb`:

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
