class CreateVerses < ActiveRecord::Migration[5.2]
  def change
    create_table :verses do |t|
      t.string :reference

      t.timestamps
    end
  end
end
