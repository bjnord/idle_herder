class AddAttributesToHero < ActiveRecord::Migration[5.1]
  def change
    add_column :heroes, :image_file, :string
    add_column :heroes, :health, :integer
    add_column :heroes, :attack, :integer
    add_column :heroes, :armor, :integer
    add_column :heroes, :speed, :integer
  end
end
