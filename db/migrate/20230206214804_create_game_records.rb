class CreateGameRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :game_records do |t|
      t.references :player, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.references :deck, null: false, foreign_key: true
      t.string :record_type, null: false

      t.timestamps
    end
  end
end
