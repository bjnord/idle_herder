class CreateHeroes < ActiveRecord::Migration[5.1]
  def change
    create_table :heroes do |t|
      t.string :name, null: false, default: ''
      t.integer :stars, null: false, default: 0
      t.string :faction, null: false, default: ''
      t.string :role, null: false, default: ''
      t.integer :power, null: false, default: 0

      t.timestamps
    end
    add_index :heroes, [:name, :stars], unique: true
  end
end
