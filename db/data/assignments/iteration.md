---
title: Iteration
slug: iteration
type: review
---

In this review assignment, you'll be introduced to the use of looping in Ruby.

In programming, you often want to perform some action repeatedly, either a fixed number of times or until some condition is met. We can achieve this using some of Ruby's looping constructs and iteration methods.

### Learning Goals

* Use the **.times** method
* Incorporate the **.while** method
* Incorporate the **for…do…end** loop method
* Use code blocks in loops to output data
* Use code blocks in loops to reassign variables
* Terminate loops early with the `break` keyword

### Implementation Details

#### Looping on a condition

Previously, we wrote a conditional expression using the `if` keyword. Consider the card game Blackjack where the goal is to get as close to 21 points without going over. You're initially dealt two cards and then you can either take another card ("hit") or not ("stand"). A simple strategy might be take another card if your score is below 17 points.

```ruby
HIT_LIMIT = 17

if score < HIT_LIMIT
  score += hit()
end
```

Assuming the `hit()` method will return the value of the next card, consider the situation where you're initially dealt 2 and 6, then you're dealt a 3. Now you have a score of 11 points which is still below the threshold of 17 we defined. What we'd like to do is to keep taking cards until we hit or exceed that threshold value. We can achieve this using a `while` loop:

```ruby
HIT_LIMIT = 17

while score < HIT_LIMIT
  score += hit()
end
```

Here we check the condition `score < HIT_LIMIT` and if it's true, we run the code within the `while` loop. This is similar to the `if` statement, except after the code in the `while` loop runs, we go back and check the condition again. If it is still true, we run the code in the loop again. This keeps happening until the condition `score < HIT_LIMIT` is false, which is how we ensure that we have taken enough cards. Below you will find the general form of the `while` loop.

```no-highlight
while <some condition>
  <code to run as long as condition is true>
end
```

Think of a while loop like a race track. The interpreter will do a lap around the race track each time the condition is true. Every time it gets back to the starting line, it checks the conditional to see if it must do another lap. The race is over when the condition returns false.

#### until

Just as the `unless` statement is a complement to `if`, Ruby also provides the `until` statement that is the complement to `while`. The code block of until will keep running as long as the condition is false. We could re-write the above example as:

```ruby
until score >= HIT_LIMIT
  score += hit()
end
```

Use whichever keyword (`while` or `until`) is clearer to read. `while` is used more often than `until`.

#### Infinite Loops

Like in the quick challenge above, where we have a loop that never gets evaluated, we can have a loop that never terminates. In programming, we call this events an **infinite loop** because it will go on forever without terminating. If this happens to you, you can terminate the program with a `ctrl+c`.

What conditions cause an infinite loop? If we do not affect change on the boolean condition that exits the loop, it will either always be false or always be true. To continue with our race track analogy, the conditional would continuously tell the runner to do another lap, and the race would never end.

```ruby
while true
  puts "it goes on and on and on."
end
```

We must introduce a way for the boolean condition to evaluate to false for the `while` loop to terminate in this case.

```ruby
MAX_TIMES = 40
count = 0

while count <= MAX_TIMES
  puts "it goes on and on and on."
  count += 1
end
```

Without affecting the value of count inside the block, the boolean expression `0 <= 40` will always be true, resulting in an infinite loop.


#### Looping a fixed number of times

Sometimes we want to repeat a process a fixed number of times. Consider dealing out a hand of draw poker where each player receives five cards. We might use something like

```ruby
player_one = "Bob"
player_two = "Gizmo"
player_three = "Bogie"

deal_card(player_one)
deal_card(player_two)
deal_card(player_three)

deal_card(player_one)
deal_card(player_two)
deal_card(player_three)

deal_card(player_one)
deal_card(player_two)
deal_card(player_three)

deal_card(player_one)
deal_card(player_two)
deal_card(player_three)

deal_card(player_one)
deal_card(player_two)
deal_card(player_three)
```

This code is very repetitive and tedious to write. In Ruby we can actually use a method `.times` defined for integers that will let us repeat a certain action _x_ number of times:

```ruby
player_one = "Bob"
player_two = "Gizmo"
player_three = "Bogie"

5.times do
  deal_card(player_one)
  deal_card(player_two)
  deal_card(player_three)
end
```

After calling `5.times` we pass in a `do..end` block that specifies the code we want to run, and Ruby will run that code 5 times for us.

We see this `do..end` block construct repeatedly in ruby. We use `do` and `end` to mark the beginning and end of a block of code that has special behavior. That behavior is indicated by the ruby method or statement that precedes the `do`.

#### The `break` statement

We can use the `break` keyword to terminate early from a loop.

```ruby
while true
  puts "Your wish is my command:"
  input = gets.chomp
  if input == 'exit'
    puts "exiting..."
    break
  end
end
```

The program above will loop infinitely until I specify the input of "exit". The `break` keyword should be applied sparingly, as in the majority of cases, you can express such a loop in a better way.

```ruby
input = nil
until input == 'exit'
  puts "Your wish is my command:"
  input = gets.chomp
  if input == 'exit'
    puts "exiting"
  end
end
```

It up to you to determine if either approach reads better, as there are trade-offs between the two examples above.

Take a moment to identify the duplication in the `until` example, and how that differs from the `while` example.
