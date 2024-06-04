class Note<ActiveRecord::Base

    belongs_to :course
    belongs_to :user, class_name: "User", foreign_key: "owner_id"
    has_many :reviews, dependent: :destroy
    has_many :note_reports, dependent: :destroy

    validates :title, presence: true
    validates :pdf, presence: true
    validates :owner_id, presence: true
    validates :course_id, presence: true

    def self.search(search)
        if search
            where('title LIKE ?', "%#{search}%")
        else
            all
        end
    end

end
