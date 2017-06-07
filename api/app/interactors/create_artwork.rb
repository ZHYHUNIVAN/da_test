class CreateArtwork < Interactors::Base
  def call
    artwork = Artwork.new(create_params)
    build_images_for(artwork)
    if artwork.save
      context.artwork = artwork
    else
      context.fail!(errors: artwork.errors, image_errors: image_errors)
    end
  end

  def build_images_for(artwork)
    images = params[:images]
    if images.present?
      images.each do |i|
        image = artwork.images.build(file: i)
        unless image.valid?
          image_errors << { filename: image.file.filename, messages: image.errors.full_messages }
        end
      end
    end
  end

  private
  def image_errors
    context.image_errors ||= []
  end

  def create_params
    params.require(:artwork).permit(:title, :description, :price, :artist_id)
  end
end