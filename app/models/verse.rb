class Verse < ActiveRecord::Base

  belongs_to :user
  has_many :subscription_verses
  has_many :subscriptions, through: :subscription_verses

  def self.random
    Verse.offset(rand(Verse.count)).first
  end
end
