class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_cart, :set_categories, :authorize!
  add_flash_types :success, :info, :warning, :danger



  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end


  def current_admin?
    current_user && current_user.admin?
  end


  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def set_categories
    @categories = Category.all
  end

  private

  def require_admin
    render file: "/public/404" unless current_admin?
  end

  def authorize!
    permission = PermissionService.new(current_user, params[:store_slug], params[:controller], params[:action])
    raise ActionController::RoutingError.new('Not Found') unless permission.authorized?
  end
end
