class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: true
    validates :username, presence: true 
    has_many :lists

    # def self.from_omniauth(auth)
    #     where(provider: auth.provider, uid: auth.uid).first_or_create do |user| #first of create is 
    #         user.provider = auth.provider
    #         user.uid = auth.uid
    #         user.email = auth.info.email
    #         user.password = SecureRandom.hex
    #     end 
    # end 

    def self.find_or_create_by_omniauth(auth_hash) #returns the instance of the user
            oauth_username = auth_hash["info"]["nickname"]
            self.where(username: oauth_username).first_or_create do |user|
                user.password = SecureRandom.hex
            # oauth_username = auth_hash["omniauth.auth"]["info"]["nickname"]
            # if user = User.find_by(:username => oauth_username) #github
            #     return user
            # else 
            #     user = User.create(:name => oauth_username, :username => oauth_username,:password => SecureRandom.hex)
            # end 
            end
    end 
end

