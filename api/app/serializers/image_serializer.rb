class ImageSerializer < ActiveModel::Serializer
  attributes :id, :width, :height, :file

  def file
    object.file.serializable_hash
  end
end
