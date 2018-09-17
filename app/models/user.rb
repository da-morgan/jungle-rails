class User < ActiveRecord::Base
    has_many :reviews

    has_secure_password 

    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, confirmation: true, presence: true, length: { minimum: 3 }
    validates :password_confirmation, presence: true
end
