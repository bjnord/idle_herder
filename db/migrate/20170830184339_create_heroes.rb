class CreateHeroes < ActiveRecord::Migration[5.1]
  def change
    create_table :heroes, id: false do |t|
      t.bigint :id, null: false
      t.string :name, null: false
      t.integer :stars, null: false
      t.string :faction, null: false
      t.string :role, null: false
      t.integer :power
    end
    add_index :heroes, :id, unique: true
    add_index :heroes, [:name, :stars], unique: true
  end
end
