class ChangeHeroesFactionToInteger < ActiveRecord::Migration[5.1]
  def up
    # static data; just need to repopulate afterward
    Hero.destroy_all
    remove_column :heroes, :faction
    add_column :heroes, :faction, :integer, null: false
    remove_column :materials, :faction
    add_column :materials, :faction, :integer
  end

  def down
    # static data; just need to repopulate afterward
    Hero.destroy_all
    remove_column :heroes, :faction
    add_column :heroes, :faction, :string, null: false
    remove_column :materials, :faction
    add_column :materials, :faction, :string
  end
end
