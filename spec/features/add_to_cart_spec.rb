require 'rails_helper'

RSpec.feature "Visitor adds items to cart", type: :feature, js: true do

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

  scenario "Add cart items" do
    # ACT
    visit root_path
    find_button('Add', match: :first).click
    save_screenshot
    # VERIFY
    expect(page).to have_link 'My Cart (1)'
  end
end