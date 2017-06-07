class ListArtists < Interactors::Base
  def call
    context.artists = if params[:ids] == 'true'
      { ids: Artist.pluck(:id) }
    else
      Artist.all
    end
  end
end
