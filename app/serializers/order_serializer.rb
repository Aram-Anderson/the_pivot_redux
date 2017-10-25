class OrderSerializer < ActiveModel::Serializer
  attributes :status, :user_id
end
