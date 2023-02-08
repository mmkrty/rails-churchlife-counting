class CreateLordsDays < ActiveRecord::Migration[7.0]
  def change
    create_table :lords_days do |t|
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
