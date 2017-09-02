class AddMaterialHeroIndexToMaterials < ActiveRecord::Migration[5.1]
  def change
    add_index :materials, :material_hero_id
  end
end
