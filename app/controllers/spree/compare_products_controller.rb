module Spree
  class CompareProductsController < Spree::StoreController
    before_filter :find_taxon, only: :index
    before_filter :find_products, only: :index
    before_filter :check_comparable_data, only: [:add, :remove]

    helper 'spree/products', 'spree/taxons'

    # We return the list of properties here so we can use them latter.
    def index
      @properties = @products.map(&:properties).flatten.uniq
    end

    def destroy
      session[:compare_products] = []
      @products = []
      render :add
    end

    def add
      session[:compare_taxon] ||= 0
      session[:compare_products] ||= []
      if @taxon.id == session[:compare_taxon]
        session[:compare_products] << params[:id]
        session[:compare_products] = session[:compare_products].uniq.last(4)
      else
        session[:compare_taxon] = @taxon.id
        session[:compare_products] = []
        session[:compare_products] << params[:id]
      end
    end

    def remove
      if session[:compare_products].include?(params[:id])
        session[:compare_products].delete(params[:id])
      end
      respond_to do |format|
        format.js { render :add }
        format.html { redirect_to compare_products_path }
      end
    end

    private


    def check_comparable_data
      @product = Spree::Product.find(params[:id])
      render nothing: true if !@product
      first_taxon = @product.taxons.joins(:taxonomy).where("spree_taxonomies.name != 'популярные товары' ").first
      @taxon = first_taxon.parent
      render nothing: true if !@taxon
    end

    # Find the taxon from the url
    def find_taxon
      @taxon = Spree::Taxon.find(session[:compare_taxon])
    end

    # Verifies that the comparison can be made inside this taxon.

    # Find the products inside the taxon, manually adding product ids to
    # the url will silently be ignored if they can't be compared inside
    # the taxon or don't exists.
    def find_products
      product_ids = session[:compare_products] || []
      if product_ids.length > 4
        flash[:notice] = Spree.t('compare_products.limit_is_4')
        product_ids = product_ids[0..3]
      elsif product_ids.length < 1
        flash[:error] = Spree.t('compare_products.insufficient_data')
        redirect_to spree.nested_taxons_path(@taxon.permalink)
      end
      @products = Spree::Product.where(id: product_ids).includes(product_properties: :property).limit(4)
    end
  end
end
