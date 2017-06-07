class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  after :remove, :clear_directory

  process :store_dimensions

  version :show do
    process :scale_by_largest_side
  end

  version :preview, from_version: :show do
    process resize_to_fill: [300, 300]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    /image\//
  end

  def dimension
    file ? ::MiniMagick::Image.open(file.file)[:dimensions] : []
  end

  def width
    dimension[0]
  end

  def height
    dimension[1]
  end

  private

  def scale_by_largest_side
    dimensions = [800]
    met = width > height ? :push : :unshift
    dimensions.public_send(met, nil)
    resize_to_limit(*dimensions)
  end

  def store_dimensions
    if file && model
      model.dimension = "#{width}x#{height}"
    end
  end

  def clear_directory
    FileUtils.remove_dir("#{Rails.root}/public/#{store_dir}", force: true)
  end
end
