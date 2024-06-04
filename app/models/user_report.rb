class UserReport < ActiveRecord::Base
    belongs_to :user, class_name: "User", foreign_key: "user_id"

    validates :reporter, presence: true
    validates :user_id, presence: true
    validates :subject, presence: true
end