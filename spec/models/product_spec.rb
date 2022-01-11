require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "can't be blank" do   #
      prod = Product.new(name:nil)
      prod.validate
      expect(prod).to_not be_valid
    end
    it "can't be blank" do   #
      prod = Product.new(price:nil)
      prod.validate
      expect(prod).to_not be_valid
    end
    it "can't be blank" do   #
      prod = Product.new
      prod.quantity
      prod.validate
      expect(prod.errors[:quantity]).to include("can't be blank")
    end
    it "can't be blank" do   #
      @category = Category.new
      @category.name = "Mobiles"
      prod = Product.new
      prod.category
      prod.validate
      expect(prod.errors[:category]).to include("can't be blank")
    end
    it "can't be blank" do   #
      @category = Category.new
      @category.name = "Mobiles"
      prod = Product.new
      prod.name = "Apple iphone 12 pro"
      prod.price = 1200
      prod.quantity = 2
      prod.category = @category
      prod.validate
      expect(prod).to be_valid
    end
  end
end
