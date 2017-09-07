class AddFactionIndexOnHeroes < ActiveRecord::Migration[5.1]
  def change
    add_index :heroes, [:stars, :faction, :name]
  end
end
