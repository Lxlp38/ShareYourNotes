class University<ActiveRecord::Base
    has_many :courses
    has_many :users
    has_many :notes
    
    validates :name, presence: true, uniqueness: true

end