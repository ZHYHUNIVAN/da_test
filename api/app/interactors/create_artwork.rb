class CreateArtwork < Interactors::Base
  def call
    artwork = Artwork.new(create_params)
    if artwork.save
      context.artwork = artwork
    else
      context.fail!(errors: artwork.errors)
    end
  end

  private

  def create_params
    params.require(:artwork).permit(:title, :description, :price, :artist_id, :width, :height, :depth)
  end
end