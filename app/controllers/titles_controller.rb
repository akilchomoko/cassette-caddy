class TitlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  # Title controller - Limited to 10 searched films:
  def index
    if params[:title][:name].present?
      @title = Title.splash_search(params[:title][:name])
    else
      @title = Title.limit(10)
    end
  end

  def show
    # refactored here, as we don't have edit, new, or others. Removed before_action too.
    @title = Title.find(params[:id])
    @title_details = @title.imdb_details
    @title_poster = @title.imdb_poster
    @rental = Rental.already_rented(@title, current_user) || Rental.new
  end

  def random
    @title = Title.order('RANDOM()').first
    redirect_to title_path(@title)
    end
  end
