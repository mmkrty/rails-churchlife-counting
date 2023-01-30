class CreatePrayerMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :prayer_meetings do |t|
      t.date :date, null: false
      t.string :location, null: false
      t.integer :adults, default: 0
      t.integer :teenagers, default: 0
      t.integer :children, default: 0
      t.integer :toddlers, default: 0

      t.timestamps
    end
  end
end
