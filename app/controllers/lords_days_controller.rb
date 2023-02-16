class LordsDaysController < ApplicationController

  def show
    @lords_days = LordsDay.all
  end

  def new
    @lords_day = LordsDay.new
  end

  def create
    @lords_day = LordsDay.new(lords_day_params)
    if @lords_day.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def lords_day_params
    params.require(:lords_day).permit(:date, :location, :adults, :teenagers, :children, :toddlers)
  end
end
