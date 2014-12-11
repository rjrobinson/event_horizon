json.set! :lessons do
  json.array! @lessons, :title, :slug, :type
end
