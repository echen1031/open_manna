class AddStoredVerseIdsToSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :stored_verse_ids, :integer, array: true, default: []
    add_index :subscriptions, :stored_verse_ids
  end
end
