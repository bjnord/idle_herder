class SetAccountHeroesDefaults < ActiveRecord::Migration[5.1]
  def change
    change_column_default :account_heroes, :level, from: nil, to: 1
    change_column_default :account_heroes, :shards, from: nil, to: 0
  end
end
