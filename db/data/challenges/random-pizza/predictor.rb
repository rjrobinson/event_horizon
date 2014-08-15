require "json"

def predict(request)
  true # REPLACE WITH YOUR CODE
end

training_set = JSON.parse(File.read("pizza_request_training.json"))

true_positive = 0
false_positive = 0
true_negative = 0
false_negative = 0

correct = 0
total = 0

training_set.each do |request|
  actual = request["requester_received_pizza"]

  request_without_answer = request.reject do |key, _|
    key == "requester_received_pizza"
  end

  predicted = predict(request_without_answer)

  if actual
    if predicted
      true_positive += 1
    else
      false_negative += 1
    end
  else
    if predicted
      false_positive += 1
    else
      true_negative += 1
    end
  end

  if predicted == actual
    correct += 1
  end

  total += 1
end

puts "True positives: #{true_positive}"
puts "False positives: #{false_positive}"
puts "True negatives: #{true_negative}"
puts "False negatives: #{false_negative}"

puts

puts sprintf(
  "True positive rate: %.2f (%d)",
  true_positive.to_f / (true_positive + false_negative),
  true_positive)

puts sprintf(
  "False positive rate: %.2f (%d)",
  false_positive.to_f / (false_positive + true_negative),
  false_positive)

puts

puts "Correct: #{correct}"
puts "Total: #{total}"

puts

puts sprintf("%% Correct: %.2f", correct.to_f / total.to_f)
