ActiveAdmin.register SubscriptionVerse do
  index do
    column :id
    column :subscription_id
    column :user_id
    column :verse_id do |sub_verse|
      Verse.find(sub_verse.verse_id).reference
    end
    column :created_at do |sub_verse|
      sub = sub_verse.subscription
      Time.use_zone(sub.time_zone) do
        sub_verse.created_at.strftime("%m/%d/%Y at %l:%M %p")
      end
    end
  end
end
