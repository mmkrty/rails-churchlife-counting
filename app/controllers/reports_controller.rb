require 'nokogiri'

class ReportsController < ApplicationController
  def weekly_stats
    # @week_number = params[:week_number].to_i || Date.today.cweek
    # @start_date = Date.commercial(Date.today.year, @week_number, 1)
    # @end_date = Date.commercial(Date.today.year, @week_number, 7)

    # @start_date_string = @start_date.strftime("%Y-%m-%d")
    # @end_date_string = @end_date.strftime("%Y-%m-%d")

    # @lords_days_data = LordsDay.where(date: @start_date..@end_date)
    #                             .group_by { |ld| ld.date.strftime("%U-%Y") }
    #                             .map { |week, instances| ["Week #{week.split('-').first.to_i - 1}, #{week.split('-').last}", instances.sum(&:total), instances.sum(&:adults), instances.sum(&:teenagers), instances.sum(&:children), instances.sum(&:toddlers)] }
    #                             .sort_by { |week, _total, _adults, _teenagers, _children, _toddlers|  Date.strptime(week, "Week %U, %Y") }

    # @prayer_meetings_data = PrayerMeeting.where(date: @start_date..@end_date)
    #                                       .group_by { |pm| pm.date.strftime("%U-%Y") }
    #                                       .map { |week, instances| ["Week #{week.split('-').first}, #{week.split('-').last}", instances.sum(&:total), instances.sum(&:adults), instances.sum(&:teenagers), instances.sum(&:children), instances.sum(&:toddlers)] }
    #                                       .sort_by { |week, _total, _adults, _teenagers, _children, _toddlers|  Date.strptime(week, "Week %U, %Y") }
    # @small_groups_data = SmallGroup.where(date: @start_date..@end_date)
    #                                .group_by { |sg| sg.date.strftime("%U-%Y") }
    #                                .map { |week, instances| ["Week #{week.split('-').first}, #{week.split('-').last}", instances.sum(&:total), instances.sum(&:adults), instances.sum(&:teenagers), instances.sum(&:children), instances.sum(&:toddlers)] }
    #                                .sort_by { |week, _total, _adults, _teenagers, _children, _toddlers|  Date.strptime(week, "Week %U, %Y") }

    @week_number = params[:week_number].to_i || Date.today.cweek
    @start_date = Date.commercial(Date.today.year, @week_number, 1)
    @end_date = Date.commercial(Date.today.year, @week_number, 7)

    # Collect data for the past 3 weeks in addition to the current week
    @group_start_date = @end_date - 21.days

    @start_date_string = @start_date.strftime("%Y-%m-%d")
    @end_date_string = @end_date.strftime("%Y-%m-%d")

    @lords_days_data = LordsDay.where(date: @group_start_date..@end_date)
                                .group_by { |ld| ld.date.strftime("%U-%Y") }
                                .map { |week, instances| ["Week #{week.split('-').first.to_i - 1}, #{week.split('-').last}", instances.sum(&:total), instances.sum(&:adults), instances.sum(&:teenagers), instances.sum(&:children), instances.sum(&:toddlers)] }
                                .sort_by { |week, _total, _adults, _teenagers, _children, _toddlers|  Date.strptime(week, "Week %U, %Y") }

    @lords_day_this_week = check_current_week(@lords_days_data)

    @prayer_meetings_data = PrayerMeeting.where(date: @group_start_date..@end_date)
                                          .group_by { |pm| pm.date.strftime("%U-%Y") }
                                          .map { |week, instances| ["Week #{week.split('-').first.to_i}, #{week.split('-').last}", instances.sum(&:total), instances.sum(&:adults), instances.sum(&:teenagers), instances.sum(&:children), instances.sum(&:toddlers)] }
                                          .sort_by { |week, _total, _adults, _teenagers, _children, _toddlers|  Date.strptime(week, "Week %U, %Y") }

    @prayer_meeting_this_week = check_current_week(@prayer_meetings_data)

    @small_groups_data = SmallGroup.where(date: @group_start_date..@end_date)
                                   .group_by { |sg| sg.date.strftime("%U-%Y") }
                                   .map { |week, instances| ["Week #{week.split('-').first.to_i}, #{week.split('-').last}", instances.sum(&:total), instances.sum(&:adults), instances.sum(&:teenagers), instances.sum(&:children), instances.sum(&:toddlers)] }
                                   .sort_by { |week, _total, _adults, _teenagers, _children, _toddlers|  Date.strptime(week, "Week %U, %Y") }

    @small_groups_this_week = check_current_week(@small_groups_data)


    @small_groups_multi_data = SmallGroup.where(date: @group_start_date..@end_date)
                               .group_by { |sg| [sg.date.strftime("%U-%Y"), sg.location] }
                               .transform_values { |instances| instances.sum(&:total) }
                               .group_by { |(week, location), _| location }
                               .map { |location, week_data| [location, week_data.sort_by { |(week, _), _| Date.strptime(week, "%U-%Y") }.map { |(week, _), total| ["Week #{week.split('-').first.to_i}, #{week.split('-').last}", total] }] }


   @current_week_small_groups_data = SmallGroup.where(date: @start_date..@end_date)
                                                .group_by(&:location)
                                                .transform_values do |small_groups|
                                                  adults = small_groups.sum(&:adults)
                                                  teenagers = small_groups.sum(&:teenagers)
                                                  children = small_groups.sum(&:children)
                                                  toddlers = small_groups.sum(&:toddlers)
                                                  total = small_groups.sum(&:total)
                                                  { adults: adults, teenagers: teenagers, children: children, toddlers: toddlers, total: total }
                                                end

  end

  def send_weekly_stats_email

    User.all.each do |user|
      html = render_to_string(partial: 'reports/weekly_stats', layout: false, locals: {
        week_number: @week_number,
        start_date_string: @start_date_string,
        lords_day_this_week: @lords_day_this_week,
        lords_days_data: @lords_days_data,
        prayer_meeting_this_week: @prayer_meeting_this_week,
        prayer_meetings_data: @prayer_meetings_data,
        small_groups_this_week: @small_groups_this_week,
        small_groups_data: @small_groups_data,
        small_groups_multi_data: @small_groups_multi_data,
        current_week_small_groups_data: @current_week_small_groups_data })
      doc = Nokogiri::HTML(html)
      content = doc.css('#weeklyStats').to_html
      ApplicationMailer.send_weekly_stats_email(user, @week_number, content).deliver_now
    end
    redirect_to reports_path, notice: 'Weekly stats emailed to all users successfully'
  end

  private

  def extract_number(string)
    number_regex = /\d+/
    number_match = string.match(number_regex)
    number_match[0].to_i
  end

  def check_current_week(meeting_data)
    return false if meeting_data == []

    extract_number(meeting_data[-1][0]) == @week_number
  end
end
