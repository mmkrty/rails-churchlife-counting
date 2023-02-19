class LordsDaysController < ApplicationController

  def index
    @lords_days = LordsDay.all.order(:date)
  end

  def show
    @lords_day = LordsDay.find(params[:id])
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
      # render partial: 'lords_day/form', locals: { lords_day: @lords_day }, status: :unprocessable_entity
    end
  end

  def edit
    @lords_day = LordsDay.find(params[:id])
  end

  def update
    @lords_day = LordsDay.find(params[:id])
    if @lords_day.update(lords_day_params)
      redirect_to lords_days_path, notice: "Lords Day updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @lords_day = LordsDay.find(params[:id])
    @lords_day.destroy
    redirect_to lords_days_path, notice: "Lords Day deleted successfully."
  end

  private

  def lords_day_params
    params.require(:lords_day).permit(:date, :location, :adults, :teenagers, :children, :toddlers)
  end
end
