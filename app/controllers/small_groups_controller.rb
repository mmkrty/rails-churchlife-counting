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

  def edit
    @small_group = SmallGroup.find(params[:id])
  end

  def update
    @small_group = SmallGroup.find(params[:id])
    if @small_group.update(small_group_params)
      redirect_to small_groups_path, notice: "Small Group updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @small_group = SmallGroup.find(params[:id])
    @small_group.destroy
    redirect_to small_groups_path, notice: "Small Group deleted successfully."
  end

  private

  def small_group_params
    params.require(:small_group).permit(:date, :location, :adults, :teenagers, :children, :toddlers)
  end
end
