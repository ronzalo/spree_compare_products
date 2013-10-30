Deface::Override.new(:virtual_path => "spree/taxons/show", :name =>"compare_products", :insert_bottom => "ul[data-hook='compare_list']",:partial=>'/shared/compare_list_products')
Deface::Override.new(:virtual_path => "spree/products/index", :name =>"compare_products", :insert_bottom => "ul[data-hook='compare_list']",:partial=>'/shared/compare_list_products')
Deface::Override.new(:virtual_path => "spree/shared/_products", :name =>"compare_links", :insert_top => "div[data-hook='compare_links']",:partial=>'/shared/compare_links')

