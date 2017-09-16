class SetAccountHeroesIsFodderDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :account_heroes, :is_fodder, from: nil, to: false
    reversible do |direction|
      direction.up { AccountHero.all.each {|ah| ah.is_fodder ||= false ; ah.wish_list=true if ah.wish_list? ; ah.save } }
    end
    change_column_null :account_heroes, :is_fodder, false
  end
end
