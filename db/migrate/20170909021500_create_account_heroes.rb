class CreateAccountHeroes < ActiveRecord::Migration[5.1]
  def change
    create_table :account_heroes do |t|
      t.references :account, index: true, null: false
      t.references :hero, index: false
      t.references :shard_type, index: false
      t.integer :level, null: false
      t.integer :shards, null: false
      t.integer :priority, null: false, default: 1
      t.boolean :is_fodder
      t.text :description

      t.timestamps
    end
  end
end
