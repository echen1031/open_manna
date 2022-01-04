class BillingPlansSync
  def self.sync
    existing_plans_by_stripeid = BillingPlan.all.each_with_object({}) do |plan, acc|
      acc[plan.stripe_id] = plan
    end

    confirmed_existing_stripeids = []

    Stripe::Plan.list({ active: true })["data"].each do |plan|
      if existing_plans_by_stripeid[plan["id"]].present?
        existing_plans_by_stripeid[plan["id"]].update!({
          stripe_plan_name: plan["nickname"],
          amount: plan["amount"],
        })
      else
        BillingPlan.create!({
          billing_product: BillingProduct.find_by({ stripe_id: plan["product"] }),
          stripe_id: plan["id"],
          stripe_plan_name: plan["nickname"],
          amount: plan["amount"],
        })
      end

      confirmed_existing_stripeids << plan["id"]
    end

    BillingPlan.where.not({ stripe_id: confirmed_existing_stripeids }).destroy_all
  end
end
