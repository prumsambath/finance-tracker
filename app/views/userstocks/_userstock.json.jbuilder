json.extract! userstock, :id, :user_id, :stock_id, :created_at, :updated_at
json.url userstock_url(userstock, format: :json)
