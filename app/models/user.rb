class User < ActiveRecord::Base
    has_many :reviews

    has_secure_password 

    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, confirmation: true, presence: true, length: { minimum: 3 }
    validates :password_confirmation, presence: true

    def self.authenticate_with_credentials(email, password)
        email = email.strip.downcase
        user = User.find_by_email(email)
        if user && user.authenticate(password)
            return user
        else
            return nil
        end
    end
end
