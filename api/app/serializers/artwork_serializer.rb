class ArtworkSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :state, :dimensions
  has_many :images
  belongs_to :artist

  def price
    object.formatted_price
  end
end
