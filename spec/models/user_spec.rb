require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user1 = User.new(name: "Jim", email: "jim@jim.com", password: "marcopolo", password_confirmation: "marcopolo")
      expect(user1).to be_valid
    end

    it "fails without a valid name" do
      user1 = User.new(name: nil, email: "jim@jim.com", password: "marcopolo", password_confirmation: "marcopolo")
        expect(user1).to_not be_valid
    end

    it "fails without a valid email" do
      user1 = User.new(name: "Jim", email: nil, password: "marcopolo", password_confirmation: "marcopolo")
        expect(user1).to_not be_valid
    end

    it "fails without a valid password" do
      user1 = User.new(name: "Jim", email: "jim@jim.com", password_confirmation: "marcopolo")
        expect(user1).to_not be_valid
    end

    it "fails without a password confirmation" do
      user1 = User.new(name: "Jim", email: "jim@jim.com", password: "marcopolo", password_confirmation: nil)
        expect(user1).to_not be_valid
    end

    it "fails when password doesn't match password confirmation" do
      user1 = User.new(name: "Jim", email: "jim@jim.com", password: "marcopolo", password_confirmation: "polomarco")
        expect(user1).to_not be_valid
    end

    it "fails when an email already exists in the database." do
      user1 = User.new(name: "Jim", email: "jim@jim.com", password: "marcopolo", password_confirmation: "marcopolo")
      user1.save!
      user2 = User.new(name: "Jim", email: "jim@jim.com", password: "marcopolo", password_confirmation: "marcopolo")
      expect(user2).to_not be_valid
    end

    it "fails when an email already exists in the database. Checks case sensitivity" do
      user1 = User.new(name: "Jim", email: "jim@jim.com", password: "marcopolo", password_confirmation: "marcopolo")
      user1.save!
      user2 = User.new(name: "Jim", email: "Jim@jIm.COM", password: "marcopolo", password_confirmation: "marcopolo")
      expect(user2).to_not be_valid
    end

    it "fails when a password is too short" do
      user3 = User.new(name: "Jim", email: "jim@jim.com", password: "m", password_confirmation: "m")
      expect(user3).to_not be_valid
    end
  end  

  describe ".authenticate-with-credentials" do
    it "passes when credentials are valid" do
      user1 = User.new(name: "Jim", email: "jim@jim.com", password: "marcopolo", password_confirmation: "marcopolo")
      user1.save!
      user1Check = User.authenticate_with_credentials("jim@jim.com", "marcopolo")
      expect(user1).to eq(user1Check)
    end

    it "fails when email is invalid" do
      user1 = User.new(name: "Jim", email: "jim@jim.com", password: "marcopolo", password_confirmation: "marcopolo")
      user1.save!
      user1Check = User.authenticate_with_credentials("jim@jim.co", "marcopolo")
      expect(user1).to_not eq(user1Check)
    end

    it "fails when password is invalid" do
      user1 = User.new(name: "Jim", email: "jim@jim.com", password: "marcopolo", password_confirmation: "marcopolo")
      user1.save!
      user1Check = User.authenticate_with_credentials("jim@jim.com", "polomarco")
      expect(user1).to_not eq(user1Check)
    end

    it "succeeds when whitespace is at the front or end of an email" do
      user1 = User.new(name: "Jim", email: "jim@jim.com", password: "marcopolo", password_confirmation: "marcopolo")
      user1.save!
      user1Check = User.authenticate_with_credentials("   jim@jim.com   ", "marcopolo")
      expect(user1).to eq(user1Check)
    end

    it "succeeds when emails are not case sensitive" do
      user1 = User.new(name: "Jim", email: "jim@jim.com", password: "marcopolo", password_confirmation: "marcopolo")
      user1.save!
      user1Check = User.authenticate_with_credentials("jIm@jiM.Com", "marcopolo")
      expect(user1).to eq(user1Check)
    end

  end
end
