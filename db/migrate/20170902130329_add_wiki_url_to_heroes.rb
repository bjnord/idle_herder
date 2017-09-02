class AddWikiUrlToHeroes < ActiveRecord::Migration[5.1]
  def change
    add_column :heroes, :wiki_url, :string
  end
end
