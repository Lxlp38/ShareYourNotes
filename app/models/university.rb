class University<ActiveRecord::Base
    has_many :courses
    has_many :users

    validates :name, presence: true
end