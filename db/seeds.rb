problems = [
  {
    prompt: "Which code snippet follows the Ruby style conventions?",
    options: [
      {
        correct: true,
        reason: "Correctly uses the `do..end` keywords for the `each` block of code.",
        body: <<OPTION
```ruby
numbers = [7, 4, 7]
sum = 0

numbers.each do |number|
  sum += number
end

puts "The total is \#{sum}"
```
OPTION
      },
      {
        correct: false,
        reason: "When using a multiline block, prefer the `do..end` syntax over `{..}`.",
        body: <<OPTION
```ruby
numbers = [7, 4, 7]
sum = 0

numbers.each { |number|
  sum += number
}

puts "The total is \#{sum}"
```
OPTION
      }
    ]
  }
]


ActiveRecord::Base.transaction do
  problems.each do |problem_hash|
    problem = PerceptionProblem.find_or_initialize_by(prompt: problem_hash[:prompt])
    problem.save!

    problem_hash[:options].each do |option_hash|
      option = problem.options.find_or_initialize_by(body: option_hash[:body])
      option.reason = option_hash[:reason]
      option.correct = option_hash[:correct]
      option.save!
    end
  end
end
