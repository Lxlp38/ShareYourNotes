class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

      def self.from_omniauth(access_token)
        data = access_token.info
        puts data['email']
        user = User.where(email: data['email']).first
    
         #Uncomment the section below if you want users to be created if they don't exist
        unless user
            user = User.create(
                username: data['name'],
                email: data['email'],
                password: Devise.friendly_token[0,20],
                role: 'user',
                university_details_id: nil,
            )
            user.save!
        end
        user
      end

    #has_secure_password

    def persisted
    end

    belongs_to :university_details, class_name: "University", foreign_key: "university_details_id", optional: true
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