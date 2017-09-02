class AddNaturalToHeroes < ActiveRecord::Migration[5.1]
  def change
    add_column :heroes, :natural, :boolean, default: false, null: false
  end
end
