class AddTextToVerseModel < ActiveRecord::Migration
  def change
    add_column :verses, :text, :string
  end
end
