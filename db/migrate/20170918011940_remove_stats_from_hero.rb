class RemoveStatsFromHero < ActiveRecord::Migration[5.1]
  def change
    remove_column :heroes, :speed, :integer
    remove_column :heroes, :armor, :integer
    remove_column :heroes, :attack, :integer
    remove_column :heroes, :health, :integer
    remove_column :heroes, :power, :integer
  end
end
