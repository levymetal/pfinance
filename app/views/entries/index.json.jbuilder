json.array!(@entries) do |entry|
  json.extract! entry, :id, :user_id, :amount, :date
  json.url entry_url(entry, format: :json)
end
