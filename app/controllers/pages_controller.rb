class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @lords_days = LordsDay.all
    @lords_day = LordsDay.new
    @prayer_meetings = PrayerMeeting.all
    @prayer_meeting = PrayerMeeting.new
    @small_groups = SmallGroup.all
    @small_group = SmallGroup.new
  end
end
