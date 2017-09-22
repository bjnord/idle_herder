class SwitchAccountHeroToSTI < ActiveRecord::Migration[5.1]
  def change
    remove_column :account_heroes, :shard_type_id, :bigint
    add_column :account_heroes, :type, :string
    reversible do |direction|
      direction.up do
        $stderr.puts "-- setting type for existing account_heroes"
        AccountHero.reset_column_information
        AccountHero.all.each do |ah|
          ah.type ||= 'SpecificAccountHero'
          ah.wish_list = true if ah.wish_list?
          ah.save!
        end
      end
    end
    change_column_null :account_heroes, :type, false
    change_column_default :account_heroes, :level, from: 1, to: 0
    add_column :account_heroes, :g_stars, :integer
    add_column :account_heroes, :g_faction, :integer
  end
end
