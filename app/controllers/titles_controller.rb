class TitlesController < ApplicationController

  # Title controller - Limited to 10 searched films: 
  def index
    @title = Title.limit(10)
  end

  def show
    # refactored here, as we don't have edit, new, or others. Removed before_action too.
    @title = Title.find(params[:id])
    @title_details = @title.imdb_details
    @title_poster = @title.imdb_poster
  end

end
