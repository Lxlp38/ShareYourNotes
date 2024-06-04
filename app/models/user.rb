class User < ActiveRecord::Base
    

    has_secure_password

    belongs_to :university_details, class_name: "University", foreign_key: "university_details_id"
    has_one :account


    has_many :tickets, dependent: :destroy
    has_many :reviews, foreign_key: "owner_id" #dependent: :destroy
    has_many :notes, foreign_key: "owner_id" #dependent: :destroy
    has_many :user_reports, dependent: :destroy

    validates :username, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :role, presence: true

end