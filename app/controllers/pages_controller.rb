class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @lords_days = LordsDay.all
    @lords_day = LordsDay.new
    @lords_days_data = LordsDay.group("date").sum(:adults).map { |k, v| [k, v + LordsDay.where(date: k).sum(:teenagers) + LordsDay.where(date: k).sum(:children) + LordsDay.where(date: k).sum(:toddlers)] }
    # :teenagers, :children, :toddlers



    @prayer_meetings = PrayerMeeting.all
    @prayer_meeting = PrayerMeeting.new
    @prayer_meetings_data = PrayerMeeting.group("date").sum(:adults).map { |k, v| [k, v + LordsDay.where(date: k).sum(:teenagers) + LordsDay.where(date: k).sum(:children) + LordsDay.where(date: k).sum(:toddlers)] }

    @small_groups = SmallGroup.all
    @small_group = SmallGroup.new
    @small_groups_data = SmallGroup.group("date").sum(:adults).map { |k, v| [k, v + LordsDay.where(date: k).sum(:teenagers) + LordsDay.where(date: k).sum(:children) + LordsDay.where(date: k).sum(:toddlers)] }
  end
end
