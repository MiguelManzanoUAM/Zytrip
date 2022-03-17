json.extract! trip, :id, :title, :body, :created_at, :updated_at
json.url trip_url(trip, format: :json)
