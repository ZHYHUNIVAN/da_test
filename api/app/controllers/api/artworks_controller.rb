module Api
  class ArtworksController < ApplicationController
    before_action :set_artwork, only: [:show, :update, :destroy, :publish, :unpublish]

    # GET /artworks
    def index
      artworks = Artwork.includes(:images, :artist)
                   .order(updated_at: :desc).paginate(page: params[:page])

      expires_in 1.day, :public => true
      render json: artworks
    end

    # GET /artworks/1
    def show
      expires_in 1.day, :public => true
      render json: @artwork
    end

    # POST /artworks
    def create
      result = CreateArtwork.call(params: params)

      if result.success?
        render json: result.artwork, status: :created
      else
        render json: { errors: result.errors }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /artworks/1
    def update
      result = UpdateArtwork.call(params: params)
      if result.success?
        render json: result.artwork
      else
        render json: { errors: result.errors, image_errors: result.image_errors }, status: :unprocessable_entity
      end
    end

    # DELETE /artworks/1
    def destroy
      @artwork.destroy
    end

    def publish
      @artwork.publish
    end

    def unpublish
      @artwork.unpublish
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_artwork
      @artwork = Artwork.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artwork_params
      params.require(:artwork).permit(
        :title, :description, :price, :artist_id,
        :width, :height, :depth, images: []
      )
    end
  end
end