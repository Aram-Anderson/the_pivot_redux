class PermissionService

  def initialize(user, controller, action)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def authorized?
    return true if controller == "stores" && action == "index"
    return true if controller == "sessions" && action.in?(["new", "create", "destroy"])
    if user.platform_admin?
      return true if controller == "users" && action.in?(%w(index))
      return true if controller == "items" && action.in?(%w(index show))
      return true if controller == "orders" && action.in?(%w(index))
    elsif user.registered?
      return true if controller == "items" && action.in?(%w(index show))
    elsif user.store_admin?
      return true if controller == "users" && action.in?(%w(index))
      return true if controller == "items" && action.in?(%w(index show))
    end
    return false
  end
  private

  attr_reader :user, :controller, :action
end
