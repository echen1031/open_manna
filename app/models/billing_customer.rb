class BillingCustomer < ActiveRecord::Base
  belongs_to :user, { required: false }
  has_many :billing_subscriptions
end
