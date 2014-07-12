---
title: Return Values
slug: return-values
type: review
---

In this review assignment, you'll explore the values returned from methods.

### Learning Goals

* Utilize values returned from methods
* Utilize returned values as conditions

### Implementation Details

#### The Value of an Expression

In Ruby, every expression has a value. When we use `irb`, every time you enter an expression the interpreter will execute the code and return the value on the next line:

```no-highlight
2.0.0-p353 :001 > 1 + 1
 => 2

2.0.0-p353 :002 > "foo".start_with?("fo")
 => true

2.0.0-p353 :003 > a = 1 + 1
 => 2
```

We say that the value that appears after `=>` is the **return value** of the expression. The value of the expression `1 + 1` is `2`. Objects of the type `String` have a method `.start_with?` which will return true if the string starts with the given prefix. In this case, the string `"foo"` starts with `"fo"` so Ruby evaluates that expression to be `true`. Variable assignments also have a return value as shown in the last example, where the value being assigned (`2`) is also the value of the expression.

### Returning Values from Methods

We saw how to define our own methods in a previous review assignment. If every expression has a value, and calling a method is an expression, what is the return value of a method that we define?

```ruby
def mystery_method
  1 + 1
end
```

In the example above, the return value of our mystery method is always `2`. In Ruby, the return value of a method is the value of the last expression that was evaluated. In this case, we only defined a single expression: `1 + 1`, so that is what gets returned. Let's look at a more involved example, say calculating the distance between two points:

```ruby
def distance(x1, y1, x2, y2)
  x_delta = x2 - x1
  y_delta = y2 - y1

  Math.sqrt(x_delta * x_delta + y_delta * y_delta)
end

distance(1, 2, 3, 4)
# => 2.8284271247461903
```

We can think of methods as factories. We supply raw materials in the form of arguments, and the finished product is the return value. In the case of the distance calculation above, we supply 4 arguments representing coordinates of two points as the raw materials. The `distance` method takes those raw materials and produces a finished product: the distance between two points. In computer science, we call this finished product a **return value**.

The return value of this method would be the value of the expression `Math.sqrt(x_delta * x_delta + y_delta * y_delta)`. The previous two lines that create the `x_delta` and `y_delta` variables are used internally as part of the method but are not exposed in the return value. If we were to call the method `distance`, we don't care about `x_delta` or `y_delta`, we just want the distance. The details of how that method calculates that value should not matter as long as it is correct and reasonably efficient. To continue with the factory example, we don't need to know the manufacturing process of an automobile. How the pieces and raw materials are combined together is irrelevant to what goes into the factory and what comes out.

You can also think of defining a method like creating a contract. For example, you can express the `distance` method above like this: "If you give me a pair of points, I'll give you the distance between them, no questions asked." This is an important point to keep in mind as you're writing methods and later when you will be defining your own classes.

#### Being Explicit

In Ruby, a method returns the value of the last expression evaluated by default. Sometimes we'll want to exit a method early with a different return value, and in that case we can use the `return` keyword.

```ruby
 def some_method
  if <check for errors>
    return nil
  end

  # continue along as usual
end
```

If the `<check for errors>` condition returns true, we probably don't want to continue on so we return early with some error value (in this case `nil`, signifying nothing was returned). You could also use the `return` keyword on the last statement of a method, although the convention in Ruby is to not use it unless you need to exit early.

Here is a concrete example:

```ruby
  def numbify(str_to_numbify)
    if str_to_numbify.class != String
      puts "Argument is not a string"
      return nil
    end

    str_to_numbify.to_i
  end
```

The explicit `return` above terminates evaluation inside the method so that `str_to_numbify.to_i` does not get evaluated when `str_to_numbify` is not of type `String`.

### More Than One Exit

The methods shown so far followed a single path where every expression was evaluated. In previous assignments, we discussed flow control using `if` statements where certain expressions were run only if some condition was met. How do conditional expressions affect the return value of a method? Consider the following:

```ruby
def max(a, b)
  if a > b
    a
  else
    b
  end
end
```

What would be the return value of the expression `max(1, 2)`? How about `max(3, 2)`? If we remember that Ruby returns the value of the last statement evaluated, we can step through this method line by line. For `max(1, 2)`, `a = 1` and `b = 2`, therefore `a > b` returns false and the `else` block is run returning the value of `b`, in this case `2`. For `max(3, 2)`, `a = 3` and `b = 2`, so `a > b` returns true and the `if` block is run returning the value of `a`, in this case `3`. Which is what we'd expect for a method called `max`: return the max of the two values given.

### Being Concise

Let's take the following program, which calculates ticket price based on age:

```ruby
if age >= SENIOR_AGE_LIMIT || age <= CHILD_AGE_LIMIT
  ticket_price = 7.00
else
  ticket_price = 10.00
end
```

When your condition logic starts to get more complicated, it might make sense to extract it into a method.

```ruby
def receives_discount?(age)
  if age >= SENIOR_AGE_LIMIT or age <= CHILD_AGE_LIMIT
    true
  else
    false
  end
end

if receives_discount?(age)
  ticket_price = 7.00
else
  ticket_price = 10.00
end
```

In the `receives_discount?` method, we use a conditional expression which returns true or false depending on the age given. But if we look at the method in more detail, what is the value of the expression `age >= SENIOR_AGE_LIMIT || age <= CHILD_AGE_LIMIT`? This expression will return `true` or `false`, which makes the `if` statement in the method redundant. We could actually rewrite the method in a much more concise form.

```ruby
def receives_discount?(age)
  age >= SENIOR_AGE_LIMIT or age <= CHILD_AGE_LIMIT
end

if receives_discount?(age)
  ticket_price = 7.00
else
  ticket_price = 10.00
end
```

This is functionally equivalent to the previous example but with fewer lines of code. Fewer lines of code means less code to maintain, and less code that can introduce bugs!

### Rules to Follow

#### Use Return Values to Improve Your Communication Through Software

Return values help us to be more expressive in our code. Like in our last example `receives_discount?(age)` is much more human readable than `age >= SENIOR_AGE_LIMIT or age <= CHILD_AGE_LIMIT`. We can **encapsulate** complicated behavior this way as means to more effectively communicate.

### Why This Matters

#### Return values provide the bottom line of behavior

Especially as our code grows more complicated, return values summarize the behavior of a method. For example, we don't need to know the implementation details behind the `reverse` instance method on a string. We just have to know what it functionally returns, a string that reverses the order of the caller's characters. Using return values to our advantage allows us to only think about outcomes or results, and not necessarily the implementation that helps us to achieve that outcome.
