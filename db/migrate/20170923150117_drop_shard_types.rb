class DropShardTypes < ActiveRecord::Migration[5.1]
  # not automatically reversible; "drop_table" doesn't handle "id: false"

  def up
    drop_table :shard_types
  end

  def down
    create_table :shard_types, id: false do |t|
      t.bigint "id", null: false
      t.integer "stars", null: false
      t.integer "faction"
      t.string "image_file"
    end
    add_index :shard_types, :id, unique: true
  end
end
