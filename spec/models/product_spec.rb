require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      @category = Category.new(name: "Footwear")
      @category.save!
      shoes = Product.new(name: "Shoes", price_cents: 3000, quantity: 10, category_id: @category.id)
      expect(shoes).to be_valid
    end

    it "fails without a product name" do
      @category = Category.new(name: "Footwear")
      @category.save!
      shoes = Product.new(price_cents: 3000, quantity: 10, category_id: @category.id)
      expect(shoes).to_not be_valid
    end

    it "fails without a product price" do
      @category = Category.new(name: "Footwear")
      @category.save!
      shoes = Product.new(name: "shoes", quantity: 10, category_id: @category.id)
      expect(shoes).to_not be_valid
    end

    it "fails without a product quantity" do
      @category = Category.new(name: "Footwear")
      @category.save!
      shoes = Product.new(name: "shoes", price_cents: 3000, category_id: @category.id)
      expect(shoes).to_not be_valid
    end

    it "fails without a product category" do
      @category = Category.new(name: "Footwear")
      @category.save!
      shoes = Product.new(name: "shoes", price_cents: 3000, quantity: 10)
      expect(shoes).to_not be_valid
    end

  end
end
