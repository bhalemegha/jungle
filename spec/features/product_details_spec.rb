require 'rails_helper'

RSpec.feature "Visitor navigates to details page", type: :feature, js: true do

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

  scenario "They see all products" do
    # ACT
    visit root_path
    find(:'css', ".actions").hover
    # find("actions").trigger(:mouseover)
    page.find_link('Details »').click
    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_link @category.name
  end
end