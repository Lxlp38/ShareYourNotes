class Note<ActiveRecord::Base
    resourcify
    
    mount_uploaders :pdf, PdfUploader
    serialize :pdf, JSON # If you use SQLite, add this line

    belongs_to :course
    belongs_to :user, class_name: "User", foreign_key: "owner_id"
    has_many :reviews, dependent: :destroy
    has_many :note_reports, dependent: :destroy

    validates :title, presence: true
    #validates :pdf, presence: true
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
