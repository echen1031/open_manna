class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.string :reference

      t.timestamps
    end
  end
end
