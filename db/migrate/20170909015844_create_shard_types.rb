class CreateShardTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :shard_types, :id => false do |t|
      t.bigint :id, null: false
      t.integer :stars, null: false
      t.integer :faction
      t.string :image_file
    end
    add_index :shard_types, :id, unique: true
  end
end
