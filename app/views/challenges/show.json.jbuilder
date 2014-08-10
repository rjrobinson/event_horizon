json.set! :challenge do
  json.extract! @challenge, :slug, :title, :body, :archive_url
end
