class ConfirmationsController < ApplicationController

  def new
    binding.pry
    @user = User.find_by(email: params[:email])
  end

end
