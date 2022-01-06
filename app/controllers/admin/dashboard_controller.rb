class Admin::DashboardController < ApplicationController
  def show
    @product_counts = Product.all.count()
    @categories_count = Category.all.count()
  end
end
