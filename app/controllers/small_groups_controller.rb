class SmallGroupsController < ApplicationController
  def index
    @small_groups = SmallGroup.all.order(:date)
  end

  def new
    @small_group = SmallGroup.new
  end

  def create
    @small_group = SmallGroup.new(small_group_params)
    if @small_group.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def small_group_params
    params.require(:small_group).permit(:date, :location, :adults, :teenagers, :children, :toddlers)
  end
end
