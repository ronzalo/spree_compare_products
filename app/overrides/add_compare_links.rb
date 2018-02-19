# frozen_string_literal: true
# frozen_string_literal: true
# frozen_string_literal: true
# Add these 2 overrides in your Spree app or extension
# because you can put 'ul[data-hook='compare_list']' not only in spree/taxons/show
# Deface::Override.new(:virtual_path => "spree/taxons/show",
#:name =>"compare_products",
#:insert_bottom => "ul[data-hook='compare_list']",
#:partial=>'spree/compare_products/products_list')
# Deface::Override.new(:virtual_path => "spree/products/index",
#:name =>"compare_products",
#:insert_bottom => "ul[data-hook='compare_list']",
#:partial=>'spree/compare_products/products_list')
Deface::Override.new(virtual_path: "spree/shared/_products",
                     name: "compare_links",
                     insert_bottom: "[data-hook = 'compare_links']",
                     partial: "spree/shared/compare_links")
