class Potepan::HomeController < ApplicationController
  def index
    @new_arrival_products = Spree::Product.includes_images_and_price.new_arrival
  end
end
