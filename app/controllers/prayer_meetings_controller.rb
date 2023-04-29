class PrayerMeetingsController < ApplicationController

  def index
    @prayer_meetings = PrayerMeeting.all.order(:date)
  end

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

  def edit
    @prayer_meeting = PrayerMeeting.find(params[:id])
  end

  def update
    @prayer_meeting = PrayerMeeting.find(params[:id])
    if @prayer_meeting.update(prayer_meeting_params)
      redirect_to prayer_meetings_path, notice: "Prayer meeting updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prayer_meeting = PrayerMeeting.find(params[:id])
    @prayer_meeting.destroy
    redirect_to prayer_meetings_path, notice: "Prayer meeting deleted successfully."
  end

  private

  def prayer_meeting_params
    params.require(:prayer_meeting).permit(:date, :location, :adults, :teenagers, :children)
  end
end
