require 'rails_helper'

RSpec.feature "Visitors sees details of product", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
  end

  scenario "Use can see details of product if details link clicked" do
    # ACT
    visit root_path
    find(:'css', ".actions").hover
    page.find_link('Details »').click
    # VERIFY
    expect(page).to have_link @category.name
    save_screenshot
  end
end