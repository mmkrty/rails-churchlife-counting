class RemoveToddlersFromPrayerMeetings < ActiveRecord::Migration[7.0]
  def change
    remove_column :prayer_meetings, :toddlers, :integer
  end
end
