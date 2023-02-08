class CreateSmallGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :small_groups do |t|
      t.date :date, null: false
      t.string :location, null: false
      t.integer :adults, default: 0
      t.integer :teenagers, default: 0
      t.integer :children, default: 0
      t.integer :toddlers, default: 0
      t.integer :total

      t.timestamps
    end
  end
end
