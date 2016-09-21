ActiveAdmin.register SubscriptionVerse do
  index do
    column :id
    column :subscription_id
    column "User", :subscription_id do |sub|
      Subscription.find(sub).user.email
    end
    column :verse_id do |verse|
      Verse.find(verse).reference
    end
    column :created_at
  end
end
