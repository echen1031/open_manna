class BillingPlan < ActiveRecord::Base
  belongs_to :billing_product
  has_many :billing_subscriptions
end
