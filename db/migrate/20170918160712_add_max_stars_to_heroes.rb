class AddMaxStarsToHeroes < ActiveRecord::Migration[5.1]
  def change
    add_column :heroes, :max_stars, :integer, default: 10, null: false
  end
end
