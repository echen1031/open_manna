class SubscriptionVerse < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :verse
  belongs_to :user

  validates :subscription_id, presence: true
  validates :verse_id, presence: true
end
