class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image, :price
end
