json.set! :challenge do
  json.extract! @challenge, :slug, :title, :body
end
