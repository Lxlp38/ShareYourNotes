class User < ActiveRecord::Base
  rolify
  after_create :assign_default_role
  #resourcify
  #has_and_belongs_to_many :roles, join_table: :users_roles

  #Mount the uploader
  mount_uploader :avatar, AvatarUploader
  after_create :build_default_account

  attr_accessor :skip_university_details_validation

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github, :google_oauth2]

         def self.from_omniauth(access_token)
          data = access_token.info
          user = User.where(email: data['email']).first

          if user
            # if user.isbanned?
            #   return { user: nil, user_data: nil, banned: true, reason: user.ban.reason, expiration: user.ban.end } # Utente trovato ma bannato, non può accedere
            # end
            if user.active_for_authentication?
              return { user: user, user_data: nil } # Utente trovato e attivo, può accedere normalmente
            else
              return { user: user, user_data: nil, activation_required: true } # Utente trovato ma richiede attivazione
            end
          else
            username = data['name'] || data['email'].split('@').first
            user = User.new(
              email: data['email'],
              username: username,
              password: Devise.friendly_token[0, 20]
            )
            user.skip_university_details_validation = true
            user.save(validate: false)
          end

          { user: user, user_data: nil }
        end


        # user.username = access_token.info.name
        # #user.image = access_token.info.image
        # #user.uid = access_token.uid
        # #user.provider = access_token.provider
        # user.save


    #has_secure_password

    def persisted
    end

    belongs_to :university_details, foreign_key: "university_details_id", optional: true
    has_one :account, dependent: :destroy
    accepts_nested_attributes_for :account, allow_destroy: true

    has_one :active_ban, -> { where(active: true) }, class_name: 'Ban'
    has_many :bans, dependent: :destroy
    accepts_nested_attributes_for :active_ban, allow_destroy: true


    has_many :tickets, dependent: :destroy
    has_many :reviews, foreign_key: "owner_id", dependent: :destroy
    has_many :notes, foreign_key: "owner_id", dependent: :destroy
    has_many :user_reports, dependent: :destroy

    validates :username, presence: true
    validates :email, presence: true, uniqueness: true, if: :password_required?
    validates :password, presence: true, on: :create, if: :password_required?
    validates :role, presence: true
    validates :university_details_id,presence: true, unless: :skip_university_details_validation?



    def assign_default_role
      self.add_role(:user) if self.roles.blank?
    end

    


    def password_required?
      #provider.blank? # Se provider è presente, non è necessaria la password
    end

    def skip_university_details_validation?
      skip_university_details_validation
    end

    def isbanned?
      return false if active_ban.nil?

      if active_ban.end < Time.now
        active_ban.update(active: false)
        return false
      else
        return true
      end
    end

    def ban(reason, expiration)
      active_ban&.update(active: false) # Deactivate the current active ban if any
      bans.create!(reason: reason, end: expiration, start: Time.now, active: true)
    end

    private

    def build_default_account
      create_account unless account
    end



end
