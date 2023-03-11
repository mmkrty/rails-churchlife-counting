class ReportsController < ApplicationController
  def weekly_stats
    @week_number = params[:week_number].to_i || Date.today.cweek
    @start_date = Date.commercial(Date.today.year, @week_number, 1)
    @end_date = Date.commercial(Date.today.year, @week_number, 7)

    @lords_days_data = LordsDay.where(date: @start_date..@end_date)
                                .group_by { |ld| ld.date.strftime("%U-%Y") }
                                .map { |week, instances| ["Week #{week.split('-').first}, #{week.split('-').last}", instances.sum(&:total), instances.sum(&:adults), instances.sum(&:teenagers), instances.sum(&:children), instances.sum(&:toddlers)] }
                                .sort_by { |week, _total, _adults, _teenagers, _children, _toddlers|  Date.strptime(week, "Week %U, %Y") }

    @prayer_meetings_data = PrayerMeeting.where(date: @start_date..@end_date)
                                          .group_by { |pm| pm.date.strftime("%U-%Y") }
                                          .map { |week, instances| ["Week #{week.split('-').first}, #{week.split('-').last}", instances.sum(&:total), instances.sum(&:adults), instances.sum(&:teenagers), instances.sum(&:children), instances.sum(&:toddlers)] }
                                          .sort_by { |week, _total, _adults, _teenagers, _children, _toddlers|  Date.strptime(week, "Week %U, %Y") }
    @small_groups_data = SmallGroup.where(date: @start_date..@end_date)
                                   .group_by { |sg| sg.date.strftime("%U-%Y") }
                                   .map { |week, instances| ["Week #{week.split('-').first}, #{week.split('-').last}", instances.sum(&:total), instances.sum(&:adults), instances.sum(&:teenagers), instances.sum(&:children), instances.sum(&:toddlers)] }
                                   .sort_by { |week, _total, _adults, _teenagers, _children, _toddlers|  Date.strptime(week, "Week %U, %Y") }
  end
end
