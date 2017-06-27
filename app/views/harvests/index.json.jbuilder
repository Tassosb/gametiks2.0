json.array!(@harvests) do |harvest|
  json.extract! harvest, :id
  json.url harvest_url(harvest, format: :json)
end
