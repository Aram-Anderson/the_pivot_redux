class OrderSerializer < ActiveModel::Serializer
  attributes :status, :user_id, :created_at, :updated_at
end
