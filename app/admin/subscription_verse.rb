ActiveAdmin.register SubscriptionVerse do
  index do
    column :id
    column :subscription_id
    column "User", :subscription_id do |sub_verse|
      Subscription.find(sub_verse.subscription_id).user.email
    end
    column :verse_id do |sub_verse|
      Verse.find(sub_verse.verse_id).reference
    end
    column :created_at do |sub_verse|
      Time.use_zone("Eastern Time (US & Canada)") do
        sub_verse.created_at.strftime("%m/%d/%Y at %l:%M %p (est)")
      end
    end
  end
end
