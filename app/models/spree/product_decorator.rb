Spree::Product.class_eval do
  scope :related_products_of, -> (product) do
    includes(:classifications, master: [:images, :default_price]).
      where("spree_products_taxons.taxon_id": product.taxons).
      where.not(id: product.id).limit(4).distinct
  end
end