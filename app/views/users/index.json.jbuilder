json.array!(@users) do |user|
  json.extract! user, :id, :name, :surname, :personal_id, :role, :is_approved
  json.url user_url(user, format: :json)
end
