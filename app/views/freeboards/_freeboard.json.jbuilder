json.extract! freeboard, :id, :title, :content, :name, :user_id, :created_at, :updated_at
json.url freeboard_url(freeboard, format: :json)
