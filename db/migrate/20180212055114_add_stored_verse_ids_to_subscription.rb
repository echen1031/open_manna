class AddStoredVerseIdsToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :stored_verse_ids, :integer, array: true, default: []
    add_index :subscriptions, :stored_verse_ids
  end
end
