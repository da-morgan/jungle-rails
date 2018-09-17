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
end
