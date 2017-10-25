class PermissionService

  def initialize(user, controller, action)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def authorized?
    return true if controller == "store/items" && action.in?(%w(index show))
    return true if controller == "stores" && action.in?(%w(index show))
    return true if controller == "orders" && action.in?(%w(index show))
    return true if controller == "dashboard" && action == "index"
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "carts" && action.in?(%w(index new update create destroy))
    return true if controller == "users" && action.in?(%w(new update create))
    if user.platform_admin?
      return true if controller == "api/v1/stores" && action.in?(%w(index destroy create new update edit))
      return true if controller == "users" && action.in?(%w(index destroy create new update edit))
      return true if controller == "items" && action.in?(%w(index show))
      return true if controller == "orders" && action.in?(%w(index new show update))
      return true if controller == "main" && action.in?(%w(index))
      return true if controller == "passwords" && action.in?(%w(new create update))
      return true if controller == "confirmations" && action.in?(%w(new))
      return true if controller == "store/manager/dashboard" && action.in?(%w(index))
      return true if controller == "store/manager/items" && action.in?(%w(index edit update new create))
      return true if controller == "store/manager/orders" && action.in?(%w(index))
      return true if controller == "platform_admin" && action.in?(%w(index))
      return true if controller == "store/admin" && action.in?(%w(index))
      return true if controller == "store/admin/users" && action.in?(%w(index update show))
      return true if controller == "dashboard" && action.in?(%w(index))
      return true if controller == "store/items" && action.in?(%w(index destroy create new update edit))
      return true if controller == "store/admin/store" && action.in?(%w(update))
      return true if controller == "categories" && action.in?(%w(index destroy create new update edit))
    elsif user.business_admin?
      return true if controller == "main" && action.in?(%w(index))
      return true if controller == "passwords" && action.in?(%w(new create update))
      return true if controller == "confirmations" && action.in?(%w(new))
      return true if controller == "store/manager/dashboard" && action.in?(%w(index))
      return true if controller == "store/manager/items" && action.in?(%w(index edit update new create))
      return true if controller == "store/manager/orders" && action.in?(%w(index))
      return true if controller == "orders" && action.in?(%w(index new show update))
      return true if controller == "users" && action.in?(%w(update destroy edit))
      return true if controller == "orders" && action.in?(%w(index))
      return true if controller == "store/admin/users" && action.in?(%w(index update show))
      return true if controller == "dashboard" && action.in?(%w(index))
      return true if controller == "store/items" && action.in?(%w(index destroy create new update edit))
      return true if controller == "store/admin/store" && action.in?(%w(update edit))
      return true if controller == "store/admin" && action.in?(%w(index))
      return true if controller == "categories" && action.in?(%w(show))
    elsif user.business_manager?
      return true if controller == "main" && action.in?(%w(index))
      return true if controller == "passwords" && action.in?(%w(new create update))
      return true if controller == "confirmations" && action.in?(%w(new))
      return true if controller == "store/manager/dashboard" && action.in?(%w(index))
      return true if controller == "store/manager/items" && action.in?(%w(index edit update new create))
      return true if controller == "store/manager/orders" && action.in?(%w(index))
      return true if controller == "users" && action.in?(%w(update destroy edit))
      return true if controller == "orders" && action.in?(%w(index new show update))
      return true if controller == "dashboard" && action.in?(%w(index))
      return true if controller == "store/items" && action.in?(%w(index destroy create new update edit))
      return true if controller == "categories" && action.in?(%w(show))
    elsif user
      return true if controller == "dashboard" && action.in?(%w(index))
      return true if controller == "main" && action.in?(%w(index))
      return true if controller == "passwords" && action.in?(%w(new create update))
      return true if controller == "confirmations" && action.in?(%w(new))
      return true if controller == "users" && action.in?(%w(update destroy edit))
      return true if controller == "orders" && action.in?(%w(index new show update))
      return true if controller == "dashboard" && action.in?(%w(index))
      return true if controller == "store/items" && action.in?(%w(index destroy create new update edit))
      return true if controller == "categories" && action.in?(%w(show))
    else
      return false
    end
  end

    private

    attr_reader :user, :controller, :action
end
