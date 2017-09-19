class RenameHeroesNaturalToIsNatural < ActiveRecord::Migration[5.1]
  def change
    rename_column :heroes, :natural, :is_natural
  end
end
