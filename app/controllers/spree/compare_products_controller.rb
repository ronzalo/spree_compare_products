module Spree
  class CompareProductsController < Spree::StoreController
    before_filter :find_taxon, :only=>:show
    before_filter :find_products,:only=>:show
    before_filter :check_comparable_data,:only=>:add_compare_product

    helper 'spree/products', 'spree/taxons'

    # We return the list of properties here so we can use them latter.
    def show
      @properties = @products.map(&:properties).flatten.uniq
      render 'spree/compare_products/show'
    end

    def clear
      session[:compare_products] = []
      @products = []
      render 'spree/compare_products/add_compare_product',:layout=>false
    end

    def add_compare_product
      session[:compare_taxon] ||= 0
      session[:compare_products] ||= []
      if @taxon.id == session[:compare_taxon]
        session[:compare_products] << params[:id]
        session[:compare_products] = session[:compare_products].uniq.last(4)
      else
        session[:compare_taxon]=@taxon.id
        session[:compare_products]=[]
        session[:compare_products] << params[:id]
      end
      @products = Spree::Product.find(:all, :conditions => { :id => session[:compare_products]} ,:limit => 4)
      render 'spree/compare_products/add_compare_product',:layout=>false
    end

    def remove_from_comparison
      if session[:compare_products].include?(params[:id])
        session[:compare_products].delete(params[:id])
      end
      @products = Spree::Product.find(:all, :conditions => { :id => session[:compare_products]} ,:limit => 4)
      render 'spree/compare_products/add_compare_product',:layout=>false
    end

    private


    def check_comparable_data
      @product=Spree::Product.find(params[:id])
      render :nothing=>true if !@product
      first_taxon=@product.taxons.joins(:taxonomy).where("spree_taxonomies.name != 'популярные товары' ").first
      @taxon=first_taxon.parent
      render :nothing=>true if !@taxon
    end

    # Find the taxon from the url
    def find_taxon
      @taxon=Spree::Taxon.find(session[:compare_taxon])
    end

    # Verifies that the comparison can be made inside this taxon.

    # Find the products inside the taxon, manually adding product ids to
    # the url will silently be ignored if they can't be compared inside
    # the taxon or don't exists.
    def find_products

      product_ids = session[:compare_products] || []
      if product_ids.length > 4
        flash[:notice] = I18n.t('compare_products.limit_is_4')
        product_ids = product_ids[0..3]
      elsif product_ids.length < 1
        flash[:error] = I18n.t('compare_products.insufficient_data')
        redirect_to "/t/#{@taxon.permalink}"
      end
      @products = Spree::Product.find(:all, :conditions => { :id => product_ids},
                                      :include => { :product_properties => :property },
                                      :limit => 4)
    end
  end
end
