Spree::Product.class_eval do
  NUMBER_OF_RELATED_PRODUCTS = 4

  def related_products_ids
    Spree::Product.joins(:classifications).where(spree_products_taxons: { taxon_id: taxons }).
      where.not(id: id).distinct.pluck(:id).sample(NUMBER_OF_RELATED_PRODUCTS)
  end

  scope :includes_images_and_price, -> { includes(master: [:images, :default_price]) }

  scope :related_products_of, -> (product) do
    includes(master: [:images, :default_price]).where(id: product.related_products_ids)
  end

  # 購入可能な商品を新しい順に商品を取得する
  scope :new_arrival, -> { where("available_on <= ?", DateTime.now).order(available_on: :desc) }

  scope :filter_by_option, -> (option_value) do
    joins(variants: :option_values).where(spree_option_values: { presentation: option_value }) if option_value.present?
  end
end
