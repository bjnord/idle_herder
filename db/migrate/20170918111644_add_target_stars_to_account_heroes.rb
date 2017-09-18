class AddTargetStarsToAccountHeroes < ActiveRecord::Migration[5.1]
  def change
    add_column :account_heroes, :target_stars, :integer
    reversible do |direction|
      direction.up do
        $stderr.puts "-- setting target_stars for existing account_heroes"
        AccountHero.reset_column_information
        AccountHero.all.each do |ah|
          ah.target_stars ||= ah.hero ? ah.hero.stars : ah.shard_type.stars
          ah.wish_list = true if ah.wish_list?
          ah.save!
        end
        $stderr.puts "count=#{AccountHero.where(target_stars: nil).count}"
      end
    end
    change_column_null :account_heroes, :target_stars, false
  end
end
