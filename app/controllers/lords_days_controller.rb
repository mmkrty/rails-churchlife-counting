class LordsDaysController < ApplicationController
  def new
    @lords_day = LordsDay.new
  end

  def create
    @lords_day = LordsDay.new(lords_day_params)
    if @tour.save
      redirect_to lords_days_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def lords_day_params
    params.require(:lords_day).permit(:date, :location, :adults, :teenagers, :childrens, :toddlers)
  end
end
