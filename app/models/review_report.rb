class ReviewReport < ApplicationRecord
    belongs_to :user
    
    belongs_to :review, class_name: "Review", foreign_key: "review_id"

    validates :review_id, presence: true
    validates :subject, presence: true
    validates :report, presence: true
end