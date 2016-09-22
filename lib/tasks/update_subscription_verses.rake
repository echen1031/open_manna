namespace :subscription_verses do
  task fill_user_id: :environment do
    sub_verses = SubscriptionVerse.all
    sub_verses.each do |sv|
      sub = sv.subscription
      user = sub.user
      sv.update_attributes(user_id: user.id)
    end
  end
end
