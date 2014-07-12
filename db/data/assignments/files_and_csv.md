---
title: File IO and CSV
slug: file-io-and-csv
type: review
---

In this review assignment, you'll use Ruby to read and write files and parse data in comma-separated value (CSV) format.

### Learning Goals

* Write a string to a file
* Read the contents of a file
* Parse the contents of a CSV file

### Implementation Details

#### Reading and Writing

When we run a program in Ruby, we use variables and methods to manipulate the data we're working with. Once the program exits, all of those variables are discarded and any information is lost. For some programs this isn't a problem, but usually we want to save some information after a program exits.

One way that information is persisted between running programs is to save it to the filesystem. For the examples here, we'll be creating some files, so let's move to a temporary directory where we can work. Run the following commands in a Terminal window to make a temporary directory:

```no-highlight
$ mkdir -p /tmp/file_test
$ cd /tmp/file_test
```

Once in this directory, we can write a short Ruby program to write a new file.

```ruby
File.open('hello.txt', 'w') do |f|
  f.puts 'hello, world!'
end
```

We save this code in a file named `write_file.rb`. Via the command line, we can determine how our program changes the filesystem.

```no-highlight
$ ls
write_file.rb

$ ruby write_file.rb

$ ls
hello.txt write_file.rb
```

Remember that `ls` will list the files in a directory, so we first check `ls` to verify that there is only one file in the directory (our ruby script `write_file.rb`). Then, we run the script with `ruby write_file.rb`. When we run the `ls` command again, we notice that a file has been created named `hello.txt`.

We can verify that the contents of `hello.txt` are correct using the `cat` command.

```no-highlight
$ cat hello.txt
hello, world!
```

{% quick_challenge %}
{% question 'how-many-args' %}
{% endquick_challenge %}

That is the string that we used in the `File.open` block when we called `f.puts 'hello, world!'`. So even after the Ruby program has ended, our file lives on with whatever we happened to write to it. We say that the file **persists** the information created by our code because it exists beyond the running of the program.

So we can write files, but how about reading it back? In Ruby we can use the same `File.open` method to read in files as long as we pass in the `r` argument instead of `w` (read instead of write). In `irb`, we can read back the file in one line using:

```no-highlight
2.0.0p353 :001 > File.open('hello.txt', 'r') { |f| f.read }
 => "hello, world!\n"
```

We get back the string we originally wrote to the `hello.txt` file in our first program using the `f.read` line. There are a lot of intricacies involved with reading and writing files but Ruby does a good job of hiding those details and makes working with the filesystem relatively straightforward.

#### Curly Braces vs. `do..end`

In the previous example we wrote a one-liner to read the contents of a file:

```ruby
  File.open('hello.txt', 'r') { |f| f.read }
```

The curly braces at the `{..}` are equivalent to using `do..end` to pass in a code block:

```ruby
File.open('hello.txt', 'r') do |f|
  f.read
end
```

{% quick_challenge %}
{% question 'how-many-ruby-args' %}
{% endquick_challenge %}

The convention in Ruby is to use the curly braces if you can fit the block on one line, otherwise use `do..end`.

### CSV

Our last example involved us writing a simple `hello, world!` message to a file. This is fine for a demonstration but it doesn't have a lot of utility. The reason we typically read and write files is to persist information between running our programs. To do this requires defining a structure for our data so that we can interpret it correctly when we read it again.

For example, consider this list of transactions:

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

Here we hard-coded each transaction into the program and then printed them out along with a running balance. But this program would be much more useful if we could read this list from a file rather than having to type it in.

When you want to persist data (in our case a list of transactions), a common structure used is a **comma-separated values (CSV)** file. Here is what our CSV file might look like given the data in the file above:

```no-highlight
amount,description,date
2000.00,payday!,2013-06-26
-1250.00,july's rent,2013-07-01
-57.12,electric,2013-07-03
-7.38,lunch at metro,2013-07-04
```

The first row is the header, which describes what each field contains.  The fields themselves are separated by commas. Each line below the header describes a single transaction, with all of the information for that transaction contained in the fields. If we save this in a file named `transactions.csv`, we can re-write our above program as:

```ruby
require 'csv'

balance = 0.0

CSV.foreach('transactions.csv', headers: true) do |row|
  balance += row[0].to_f

  puts "Amount: #{row[0]}"
  puts "Description: #{row[1]}"
  puts "Date: #{row[2]}"
  puts "Balance: #{balance}"
  puts
end
```

In this program, we're using Ruby's `CSV` class to read the file we created. The `.foreach` method takes the filename (`transactions.csv`) and some additional options (`headers: true` so it knows the first row is a header). We give it a block with some code we want to run for each of the rows in the CSV file. In our case we want to calculate a running balance for each transaction and print out some additional details.

Running the program outputs the following:

```no-highlight
$ ruby print_transactions.rb
Amount: 2000.00
Description: payday!
Date: 2013-06-26
Balance: 2000.0

Amount: -1250.00
Description: july's rent
Date: 2013-07-01
Balance: 750.0

Amount: -57.12
Description: electric
Date: 2013-07-03
Balance: 692.88

Amount: -7.38
Description: lunch at metro
Date: 2013-07-04
Balance: 685.5
```

This is just for the small sample file we created, but you can supply a different file with hundreds of transactions and the program should run just fine. In fact, CSV is a very common format and some banks let you download your account history as a CSV file that you could process or open in a program like Excel. Using a standardized format like CSV allows you to leverage core libraries rather than trying to define your own protocol for storing data.

### Rules To Follow

#### Files Can Persist Data For Your Programs

Use files as the simplest form of reading and writing data in your programs. Files and their contents will be persisted after a program runs.

#### Embrace Standard Formats to Avoid Unnecessary Work

### Why This Is Important

#### A lot can be done with files

Particularly in a Rails environment, we tend to think in terms of storing data in databases. Alternatively, files can actually do a great deal, and sometimes more effectively than databases do. Data where the structure is weak or absent may suit files rather than databases, and files don't require the technical overhead of a database running and configured to work with the app.

When it comes to structured data, CSV is useful not only for the reasons of providing structure, but also because of the simple, compatible nature of the file format with tools like spreadsheets. And when it comes to reading data, most databases have CSV export capacities, allowing you to access their data when access to the database itself is impossible. Sample datasets are often delivered in the form of CSV files.
