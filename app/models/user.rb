class User < ActiveRecord::Base
  rolify 
  after_create :assign_default_role
  resourcify
  has_and_belongs_to_many :roles, join_table: :users_roles
  
  #Mount the uploader
  mount_uploader :avatar, AvatarUploader


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github, :google_oauth2]

      def self.from_omniauth(access_token)
        data = access_token.info
        provider = access_token.provider
        user = User.where(email: data['email']).first
    
        puts "data: #{data}"

        unless user
          user = User.create(
            username: Account.validateName(provider, data),
            email: data['email'],
            password: Devise.friendly_token[0,20],
            role: 'user',
            university_details_id: nil,
            account_attributes: { provider.to_sym => Account.validateAttribute(provider, data)}
          )
          user.save!
        end

        if user.account[provider] == 'false'
          user = nil
        else
            user.account.update(provider.to_sym => Account.validateAttribute(provider, data))
            user.save!
          user.save!
        end

        # user.username = access_token.info.name
        # #user.image = access_token.info.image
        # #user.uid = access_token.uid
        # #user.provider = access_token.provider
        # user.save
        user
      end

    #has_secure_password

    def persisted
    end

    belongs_to :university_details, foreign_key: "university_details_id", optional: true
    has_one :account #class_name: "Account", dependent: :destroy, :required => false
    accepts_nested_attributes_for :account


    has_many :tickets, dependent: :destroy
    has_many :reviews, foreign_key: "owner_id", dependent: :destroy
    has_many :notes, foreign_key: "owner_id", dependent: :destroy
    has_many :user_reports, dependent: :destroy

    validates :username, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, on: :create
    validates :role, presence: true
    validates :university_details_id,presence: true
    

    def assign_default_role
      self.add_role(:user) if self.roles.blank?
    end

end