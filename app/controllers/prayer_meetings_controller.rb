class PrayerMeetingsController < ApplicationController
  def new
    @prayer_meeting = PrayerMeeting.new
  end

  def create
    @prayer_meeting = PrayerMeeting.new(prayer_meeting_params)
    if @prayer_meeting.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def prayer_meeting_params
    params.require(:prayer_meeting).permit(:date, :location, :adults, :teenagers, :children, :toddlers)
  end
end
