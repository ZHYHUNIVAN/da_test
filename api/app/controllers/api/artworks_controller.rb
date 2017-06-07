module Api
  class ArtworksController < ApplicationController
    before_action :set_artwork, only: [:show, :update, :destroy, :publish, :unpublish]

    # GET /artworks
    def index
      artworks = Artwork.all

      render json: artworks
    end

    # GET /artworks/1
    def show
      render json: @artwork
    end

    # POST /artworks
    def create
      result = CreateArtwork.call(params: params)

      if result.success?
        render json: result.artwork, status: :created
      else
        render json: { errors: result.errors, image_errors: result.image_errors }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /artworks/1
    def update
      if @artwork.update(artwork_params)
        render json: @artwork
      else
        render json: { errors: @artwork.errors }, status: :unprocessable_entity
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
        :title, :description, :price, :artist_id, images: []
      )
    end
  end
end