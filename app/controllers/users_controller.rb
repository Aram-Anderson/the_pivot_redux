class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      ConfirmationSender.send_confirmation_to(@user)
      redirect_to new_confirmation_path
    else
      render :new
    end
  end


  def edit
    @user = current_user
  end

  def update
    if current_admin?
      current_user.update(user_params)
      redirect_to admin_dashboard_index_path
    elsif current_user != nil
      current_user.update(user_params)
      redirect_to dashboard_index_path
    else
      render file: "/public/404"
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :address)
  end

end
