class CreateMaterials < ActiveRecord::Migration[5.1]
  def change
    create_table :materials do |t|
      t.references :hero, index: true, null: false
      t.integer :count, null: false
      t.bigint :material_hero_id
      t.integer :stars
      t.string :faction
    end
  end
end
