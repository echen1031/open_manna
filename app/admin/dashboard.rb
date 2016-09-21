ActiveAdmin.register_page "Dashboard" do
  menu priority: 1
  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel "Recent Outgoign Texts" do
          table_for SubscriptionVerse.order("created_at desc").limit(10) do
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
      end
    end
  end
end
