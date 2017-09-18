class SetAccountHeroesIsFodderDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :account_heroes, :is_fodder, from: nil, to: false
    reversible do |direction|
      direction.up do
        $stderr.puts "-- setting is_fodder for existing account_heroes"
        AccountHero.all.each do |ah|
          ah.is_fodder ||= false
          ah.wish_list = true if ah.wish_list?
          ah.save!
        end
      end
    end
    change_column_null :account_heroes, :is_fodder, false
  end
end
