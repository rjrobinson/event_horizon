json.set! :lesson do
  json.extract! @lesson, :slug, :title, :body, :archive_url
end
