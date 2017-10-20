class ConfirmationsController < ApplicationController

  def new
    @user = current_user
  end

end
