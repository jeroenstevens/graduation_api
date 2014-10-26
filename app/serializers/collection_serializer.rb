class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url

  has_many :items
end
