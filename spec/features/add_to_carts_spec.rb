require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Cart updates when a product is added to the cart" do
    # ACT
      visit root_path

      first("article.product").click_button('Add')
      
      visit './cart'

      expect(page).to have_css 'table'
      
      sleep 2
      save_screenshot

  end


end
