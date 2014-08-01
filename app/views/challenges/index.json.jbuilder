json.set! :challenges do
  json.array! @challenges, :title, :slug
end
