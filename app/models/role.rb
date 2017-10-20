class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  enum role: ["default", "business_manager", "business_admin", "platform_admin"]
end
