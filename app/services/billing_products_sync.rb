class BillingProductsSync
  def self.sync
    existing_products_by_stripeid = BillingProduct.all.each_with_object({}) do |product, acc|
      acc[product.stripe_id] = product
    end

    confirmed_existing_stripeids = []

    Stripe::Product.list({ active: true })["data"].each do |product|
      if existing_products_by_stripeid[product["id"]].present?
        existing_products_by_stripeid[product["id"]].update!({ stripe_product_name: product["name"] })
      else
        BillingProduct.create!({
          stripe_id: product["id"],
          stripe_product_name: product["name"],
        })
      end

      confirmed_existing_stripeids << product["id"]
    end

    BillingProduct.where.not({ stripe_id: confirmed_existing_stripeids }).destroy_all
  end
end
