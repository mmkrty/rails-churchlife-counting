class UsersController < ApplicationController
  def create
    User.create(user_params)
    redirect_to users_path, notice: "User created successfully"
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "User successfully deleted."
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :admin, :password, :password_confirmation)
  end
end
