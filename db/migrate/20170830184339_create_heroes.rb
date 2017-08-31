class CreateHeroes < ActiveRecord::Migration[5.1]
  def change
    create_table :heroes, :id => false do |t|
      t.integer :id, null: false, default: 0
      t.string :name, null: false, default: ''
      t.integer :stars, null: false, default: 0
      t.string :faction, null: false, default: ''
      t.string :role, null: false, default: ''
      t.integer :power, null: false, default: 0
    end
    add_index :heroes, :id, unique: true
    add_index :heroes, [:name, :stars], unique: true
  end
end
