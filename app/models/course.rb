class Course<ActiveRecord::Base

    belongs_to :university
    has_many :notes, dependent: :destroy

    validates :name, presence: true
    validates :university_id, presence: true

    def self.search(search)
        if search
            where('name LIKE ?', "%#{search}%")
        else
            all
        end
    end

end    