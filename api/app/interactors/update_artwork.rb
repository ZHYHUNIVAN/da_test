class UpdateArtwork < Interactors::Base
  def call
    artwork = Artwork.find(params[:id])
    artwork.assign_attributes(update_params)
    build_image(artwork)
    if artwork.save
      context.artwork = artwork
    else
      context.fail!(errors: artwork.errors, image_errors: image_errors)
    end
  end

  #This cshould be moved to sidekiq
  def build_image(artwork)
    image = params[:image]
    if image.present?
      image = artwork.images.build(file: image)
      unless image.valid?
        image_errors << {filename: image.file.filename, messages: image.errors.full_messages}
      end
    end
  end

  private
  def image_errors
    context.image_errors ||= []
  end

  def images_params
    params.permit(images: {})
  end

  def update_params
    params.fetch(:artwork, {}).permit(:title, :description, :price, :width, :height, :depth)
  end
end