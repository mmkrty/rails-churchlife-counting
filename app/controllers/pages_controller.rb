class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @lords_day = LordsDay.new
    @lords_days = LordsDay.all
    @lords_days_data = @lords_days.map { |ld| [ld.date, ld.total] }


    @prayer_meeting = PrayerMeeting.new
    @prayer_meetings = PrayerMeeting.all
    @grouped_prayer_meetings = @prayer_meetings.group_by(&:date)
    @prayer_meetings_data = @grouped_prayer_meetings.map do |date, meetings|
      [date, meetings.sum(&:total)]
    end

    @small_group = SmallGroup.new
    @small_groups = SmallGroup.all
    @small_groups_data = @small_groups.map { |ld| [ld.date, ld.total] }
  end
end
