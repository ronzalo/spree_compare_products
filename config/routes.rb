Spree::Core::Engine.routes.draw do
  # Add your extension routes here
get '/compare_products', :controller => 'compare_products', :action => 'show'
get '/add_to_compare/:id', :controller => 'compare_products', :action => 'add_compare_product'
get '/remove_from_comparison/:id', :controller => 'compare_products', :action => 'remove_from_comparison'
get '/compare_products/clear', :controller => 'compare_products', :action => 'clear'
end
