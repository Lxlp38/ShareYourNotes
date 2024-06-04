class NoteReport<ActiveRecord::Base

    belongs_to :note
    
    validates :report, presence: true
    validates :subject, presence: true
    validates :note_id, presence: true

end