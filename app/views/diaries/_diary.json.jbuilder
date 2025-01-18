json.extract! diary, :id, :user_id, :text, :tension, :created_at, :updated_at
json.url diary_url(diary, format: :json)
