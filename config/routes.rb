Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  resources :compare_products, :only => [:index, :destroy] do
    member do
      put 'add'
      delete 'remove'
    end
  end
end
