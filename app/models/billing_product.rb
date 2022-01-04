class BillingProduct < ActiveRecord::Base
  has_many :billing_plans
end
