class BillingSubscription < ApplicationRecord
  belongs_to :billing_plan
  belongs_to :billing_customer
end
