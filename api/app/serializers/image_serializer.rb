class ImageSerializer < ActiveModel::Serializer
  attributes :id, :width, :height, :file
  has_one :artwork

  def file
    object.file.serializable_hash
  end
end
