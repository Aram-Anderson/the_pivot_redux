class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  enum role: ["business_manager", "business_admin"]
end
