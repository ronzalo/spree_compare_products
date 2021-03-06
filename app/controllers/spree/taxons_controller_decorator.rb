# frozen_string_literal: true
Spree::TaxonsController.class_eval do
  before_action :find_compare_products, only: :show

  protected

  def find_compare_products
    @compare_products = Spree::Product.where(id: session[:compare_products]).limit(4)
  end
end
