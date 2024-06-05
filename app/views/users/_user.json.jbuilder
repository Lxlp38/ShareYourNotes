json.extract! user, :id, :username, :university_details_id, :role, :created_at, :update_at, :email, :encrypted_password, :reset_password_sent_at, :remeber_created_at, :created_at, :updated_at
json.url user_url(user, format: :json)
