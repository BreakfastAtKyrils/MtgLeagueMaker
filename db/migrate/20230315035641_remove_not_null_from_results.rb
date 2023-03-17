class RemoveNotNullFromResults < ActiveRecord::Migration[7.0]
  def up
    change_column :game_records, :result, :integer, null: true
  end

  def down
    change_column :game_records, :result, :integer, null: false
  end
end
