class ArtworkSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :state
  has_many :images
  belongs_to :artist

  def price
    object.formatted_price
  end
end
