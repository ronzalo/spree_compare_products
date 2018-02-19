# frozen_string_literal: true
Deface::Override.new(virtual_path: "spree/shared/_products",
                     name: "compare_links",
                     insert_bottom: "[data-hook = 'compare_links']",
                     partial: "spree/shared/compare_links")
