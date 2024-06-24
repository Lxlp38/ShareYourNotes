class Account < ActiveRecord::Base

    belongs_to :user, class_name: "User"

    def self.validateAttribute(provider, data)
        case provider
        when 'google_oauth2'
            return data.name.nil? ? data.email.split('@').get[1] : data.name
        when 'github'
            return data.urls.GitHub
        end
    end

    def self.validateName(provider, data)
        case provider
        when 'google_oauth2'
            return data['name'].nil? ? data['email'].split('@').get[1] : data['name']
        when 'github'
            return data['name'].nil? ? data['nickname'] : data['name']
        end
    end

    # def self.authorize(account, provider)
    #     account[provider] = 'true'
    # end

end



# when 'google_oauth2'
#     return data['name'].nil? ? data['email'].split('@').get[1] : data['name']
