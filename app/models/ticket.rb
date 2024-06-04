class Ticket<ActiveRecord::Base

    belongs_to :user, class_name: "User", foreign_key: "user_id"

    validates :user_id, presence: true
    validates :subject, presence: true
    validates :text, presence: true
end