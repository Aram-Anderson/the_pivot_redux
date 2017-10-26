class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :image
end
