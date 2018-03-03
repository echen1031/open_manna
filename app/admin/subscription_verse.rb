ActiveAdmin.register SubscriptionVerse do
  permit_params :subscription_id, :user_id, :verse_id

  index do
    column :id
    column :subscription_id
    column :user_id
    column :verse_id do |sub_verse|
      sub_verse.verse.reference
    end
    column :created_at do |sub_verse|
      sub = sub_verse.subscription
      Time.use_zone(sub.time_zone) do
        sub_verse.created_at.strftime("%m/%d/%Y at %l:%M %p")
      end
    end
  end
end
