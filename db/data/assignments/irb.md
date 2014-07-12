---
title: IRB
slug: irb
type: review
---

In this review assignment, you'll be introduced to Interactive Ruby - IRB. IRB is a console that can be run in the Terminal, and allows the execution of single and multi-line Ruby statements.

### Learning Goals

* Run `irb` in the Terminal
* Exit and terminate `irb` sessions
* Run Ruby statements in `irb`
* Persist values in `irb` within the current session

### Implementation Details

#### Interactive Ruby

Ruby comes with a tool, called `irb`, which lets us enter ruby statements and evaluate them immediately, instead of them existing in a file. `irb` stands for **I**nteractive **R**u**b**y. `irb` can be a great place to experiment with ruby. IRB gives us immediate feedback on the code we submit. To get started, we simply type `irb` in our terminal:

```no-highlight
$ irb
2.0.0-p353 :001 >
```

In the above example, the `$` sign represents the terminal prompt where we ran the `irb` command which then opened up the `irb` prompt. The `2.0.0-p353` part represents the version of Ruby we're using (yours may be different) and the `:001` part is the line number of this session. To exit out of `irb`, we can just type `exit`:

```no-highlight
$ irb
2.0.0-p353 :001 > exit
$
```

So what can we do with `irb`? Anything that you can normally do with ruby.

```no-highlight
> # expression evaluation
> 1 + 1
 => 2

> # variable assignment
> name = "Gizmo"
 => "Gizmo"

> # method calls on a variable
> name.reverse
 => "omziG"

> name.start_with?("Gi")
 => true

> name.end_with?("zma")
 => false

> # statement that prints out the value contained within our variable
> puts "hello, #{name}!"
hello, Gizmo!
 => nil
```

In the above examples, `#` represents the start of a comment. Ruby will simply ignore anything that comes after the `#` but we've used it here to explain what we're doing in subsequent lines.

After each of the above examples were entered, `irb` evaluated the given expression and outputted the **return value** of that expression on the following line preceded by `=>`. For the expression `1 + 1`, Ruby evaluates that to be `2`.

The next expression assigns the value `"Gizmo"` to the variable `name`. `irb` will remember variable assignments for the remainder of the session so we can re-use `name` in subsequent expressions. Since `name` contains the value `"Gizmo"` which is a string, we can use some of the built-in instance methods for strings in Ruby such as `reverse` or test methods such as `start_with?` and `end_with?`. We can refer to the [ruby documentation](http://ruby-doc.org/stdlib-2.0/libdoc/stringio/rdoc/StringIO.html) to identify all of the methods we can call on string objects.

The last example uses the method `puts` which outputs the given string to the terminal.

As you're working through the remaining units, take advantage of the feedback you receive from `irb` to help reinforce new concepts and Ruby syntax. It's an invaluable tool to get more comfortable with the language and for understanding how the Ruby interpreter will evaluate a given expression.

### Rules to Follow

#### Use IRB Exclusively for Experimentation and Exploration

IRB is great for experimenting and discovering what methods are available to you. All of this is true, but it is not intended for prolonged development, because it doesn't save the code you write. For larger projects and when not experimenting, always write your code in a a `.rb` file.

### Why This Matters

#### IRB Gives Us a Pseudo-Command Line Interface For Working With Ruby

We can use IRB to quickly gain insight on how ruby as a language behaves. We can also use IRB to explore objects and their correlating instance methods.
