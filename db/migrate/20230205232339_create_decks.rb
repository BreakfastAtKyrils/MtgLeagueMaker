class CreateDecks < ActiveRecord::Migration[7.0]
  def change
    create_table :decks do |t|
      t.string :name, null: false
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
