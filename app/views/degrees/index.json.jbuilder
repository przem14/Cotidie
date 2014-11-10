json.array!(@degrees) do |degree|
  json.extract! degree, :id, :value, :activity, :description
  json.url degree_url(degree, format: :json)
end
