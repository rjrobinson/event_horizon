What does it take to receive a free pizza? The Reddit community has organized [Random Acts of Pizza][reddit_raop], a subreddit where strangers can help each other out by ordering pizzas for those in need. With this challenge you'll write a program to predict whether a request for pizza will be fulfilled given information about the user and the request itself.

To write and test your program you can use a collection of 4040 requests that include various features about the user and the request and whether or not the user received a pizza. The data was collected and shared by [Althoff et al.][althoff_etal] and is available in JSON format.

Write a method `predict` that receives a single request for pizza and returns `true` or `false` as to whether you believe they'll receive a pizza. The method can utilize all of the attributes of the request except for the `"requester_received_pizza"` attribute which should only be used to check the results. Here is an example of a `predict` method that checks whether the request contains the word *please*:

```ruby
def predict(request)
  request["request_text"].include?("please")
end
```

You can use the code in `predictor.rb` which will run your `predict` method through all 4040 samples and output the performance. For example, the above implementation of `predict` correctly predicts 72% of pizza requests:

```no-highlight
True positives: 52
False positives: 178
True negatives: 2868
False negatives: 942

True positive rate: 0.05 (52)
False positive rate: 0.06 (178)

Correct: 2920
Total: 4040

% Correct: 0.72
```

The goal is to maximize the amount of true positives while minimizing the amount of false positives. It might be worth looking at [decision trees][decision_tree] as a way of separating successful requests from unsuccessful ones.

[reddit_raop]: http://www.reddit.com/r/randomactsofpizza
[althoff_etal]: http://cs.stanford.edu/~althoff/raop-dataset/
[decision_tree]: http://en.wikipedia.org/wiki/Decision_tree
