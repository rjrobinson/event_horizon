json.set! :comment do
  json.extract! @comment, :body, :created_at
  json.set! :user, @comment.user.username
end
