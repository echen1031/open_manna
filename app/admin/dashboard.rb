ActiveAdmin.register_page "Dashboard" do
  menu priority: 1
  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel "Recent Outgoign Texts" do
          table_for SubscriptionVerse.order("created_at desc").limit(10) do
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
      end
    end
  end
end
