class SubscriptionVerse < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :verse

  validates :subscription_id, presence: true
  validates :verse_id, presence: true
end
