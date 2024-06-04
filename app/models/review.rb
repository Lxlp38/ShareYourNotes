class Review<ActiveRecord::Base

    belongs_to :user, class_name: "User", foreign_key: "owner_id"
    belongs_to :note, class_name: "Note", foreign_key: "note_id"
    
    has_many :review_reports, dependent: :destroy

    validates :title, presence: true
    validates :text, presence: true
    validates :rating, presence: true
    validates :owner_id, presence: true
    validates :note_id, presence: true

end