problems = [
  {
    prompt: "Which code snippet follows the Ruby style conventions?",
    options: [
      {
        correct: true,
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
        body: <<OPTION
numbers = [7, 4, 7]
sum = 0

numbers.each { |number|
  sum += number
}

puts "The total is \#{sum}"
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
      option.correct = option_hash[:correct]
      option.save!
    end
  end
end
