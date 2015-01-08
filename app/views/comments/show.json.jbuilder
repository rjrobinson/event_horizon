json.set! :comment do
  json.extract! @comment, :html_body, :created_at
  json.set! :user, @comment.user.username
end
