class AddTextToVerseModel < ActiveRecord::Migration[5.2]
  def change
    add_column :verses, :text, :string
  end
end
