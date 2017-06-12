class UpdateArtwork < Interactors::Base
  def call
    artwork = Artwork.find(params[:id])
    build_images_for(artwork)
    if artwork.save
      context.artwork = artwork
    else
      context.fail!(errors: artwork.errors, image_errors: image_errors)
    end
  end

  #This cshould be moved to sidekiq
  def build_images_for(artwork)
    images = params[:images]
    if images.present?
      images.values.each do |i|
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

  def images_params
    params.permit(images: {})
  end

  def update_params
    params.require(:artwork).permit(:title, :description, :price, :width, :height, :depth)
  end
end