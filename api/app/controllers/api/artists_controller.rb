module Api
  class ArtistsController < ApplicationController
    before_action :set_artist, only: [:show, :update, :destroy]

    # GET /artists
    def index
      result = ListArtists.call(params: params)

      render json: result.artists
    end
  end
end
