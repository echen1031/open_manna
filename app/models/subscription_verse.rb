class SubscriptionVerse < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :verse
end
