class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @lords_day = LordsDay.new
    @lords_days = LordsDay.all
    # @lords_days_data = @lords_days.map { |ld| [ld.date, ld.total] }
    @lords_days_data = @lords_days.group_by { |ld| ld.date.strftime("%U-%Y") }
                                  .map { |week, instances| ["Week #{week.split('-').first}, #{week.split('-').last}", instances.sum(&:total)] }
                                  .sort_by { |week, _total| Date.strptime(week, "Week %U, %Y") }

    @lords_latest_date = LordsDay.maximum(:date)
    @latest_lords_day = LordsDay.where(date: @lords_latest_date)
    @latest_lords_day_adults = @latest_lords_day.map(&:adults).sum
    @latest_lords_day_teenagers = @latest_lords_day.map(&:teenagers).sum
    @latest_lords_day_children = @latest_lords_day.map(&:children).sum
    @latest_lords_day_toddlers = @latest_lords_day.map(&:toddlers).sum
    @latest_lords_day_total_sum = @latest_lords_day.map(&:total).sum

    @latest_lords_day_pie_chart_data = [
      ["Adults", (@latest_lords_day_adults / @latest_lords_day_total_sum.to_f * 100).round(2)],
      ["Teenagers", (@latest_lords_day_teenagers / @latest_lords_day_total_sum.to_f * 100).round(2)],
      ["Children", (@latest_lords_day_children / @latest_lords_day_total_sum.to_f * 100).round(2)],
      ["Toddlers", (@latest_lords_day_toddlers / @latest_lords_day_total_sum.to_f * 100).round(2)],
    ]


    @prayer_meeting = PrayerMeeting.new
    @prayer_meetings = PrayerMeeting.all
    # @grouped_prayer_meetings = @prayer_meetings.group_by(&:date)
    # @prayer_meetings_data = @grouped_prayer_meetings.map do |date, meetings|
    #   [date, meetings.sum(&:total)]
    # end
    @prayer_meetings_data = @prayer_meetings.group_by { |pm| pm.date.strftime("%U-%Y") }
                                            .map { |week, instances| ["Week #{week.split('-').first}, #{week.split('-').last}", instances.sum(&:total)] }
                                            .sort_by { |week, _total| Date.strptime(week, "Week %U, %Y") }

    @prayer_latest_date = PrayerMeeting.maximum(:date)
    @lastest_prayer_meetings = PrayerMeeting.where(date: @prayer_latest_date)
    @lastest_prayer_meetings_adults = @lastest_prayer_meetings.map(&:adults).sum
    @lastest_prayer_meetings_teenagers = @lastest_prayer_meetings.map(&:teenagers).sum
    @lastest_prayer_meetings_children = @lastest_prayer_meetings.map(&:children).sum
    @lastest_prayer_meetings_toddlers = @lastest_prayer_meetings.map(&:toddlers).sum
    @lastest_prayer_meetings_total_sum = @lastest_prayer_meetings.map(&:total).sum

    @lastest_prayer_meetings_pie_chart_data = [
      ["Adults", (@lastest_prayer_meetings_adults / @lastest_prayer_meetings_total_sum.to_f * 100).round(2)],
      ["Teenagers", (@lastest_prayer_meetings_teenagers / @lastest_prayer_meetings_total_sum.to_f * 100).round(2)],
      ["Children", (@lastest_prayer_meetings_children /  @lastest_prayer_meetings_total_sum.to_f * 100).round(2)],
      ["Toddlers", (@lastest_prayer_meetings_toddlers /  @lastest_prayer_meetings_total_sum.to_f * 100).round(2)],
    ]

    @small_group = SmallGroup.new
    @small_groups = SmallGroup.all
    @grouped_small_groups = @small_groups.group_by(&:date)
    @small_groups_data = @grouped_small_groups.map do |date, meetings|
      [date, meetings.sum(&:total)]
    end

    @small_latest_date = SmallGroup.maximum(:date)
    @lastest_small_groups = SmallGroup.where(date: @small_latest_date)
    @lastest_small_groups_adults = @lastest_small_groups.map(&:adults).sum
    @lastest_small_groups_teenagers = @lastest_small_groups.map(&:teenagers).sum
    @lastest_small_groups_children = @lastest_small_groups.map(&:children).sum
    @lastest_small_groups_toddlers = @lastest_small_groups.map(&:toddlers).sum
    @lastest_small_groups_total_sum = @lastest_small_groups.map(&:total).sum

    @lastest_small_groups_pie_chart_data = [
      ["Adults", (@lastest_small_groups_adults / @lastest_small_groups_total_sum.to_f * 100).round(2)],
      ["Teenagers", (@lastest_small_groups_teenagers / @lastest_small_groups_total_sum.to_f * 100).round(2)],
      ["Children", (@lastest_small_groups_children /  @lastest_small_groups_total_sum.to_f * 100).round(2)],
      ["Toddlers", (@lastest_small_groups_toddlers /  @lastest_small_groups_total_sum.to_f * 100).round(2)],
    ]
  end

  def pie_chart_data(meeting)
    [
      ["Adults", (meeting.adults / meeting.total.to_f * 100).round(2)],
      ["Teenagers", (meeting.teenagers / meeting.total.to_f * 100).round(2)],
      ["Children", (meeting.children / meeting.total.to_f * 100).round(2)],
      ["Toddlers", (meeting.toddlers / meeting.total.to_f * 100).round(2)],
    ]
  end
end
