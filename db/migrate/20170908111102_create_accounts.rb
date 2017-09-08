class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.references :user, null: false
      t.string :player_name, null: false
      t.string :server
      t.string :guild_name
      t.integer :level
      t.text :description
      t.integer :icon_hero_id
      t.string :player_id
      t.string :vip_level

      t.timestamps
    end
    add_index :accounts, [:user_id, :player_name], unique: false
  end
end
