class UsersController < ApplicationController
  def show
    @rentals = current_user.rentals.order(start_date: :desc)
  end

  def edit
  end

  def update
  end

  def index
    @users = User.near(current_user.address, 20) || User.all

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @users.geocoded.map do |user|
      poster = latest_rental_poster(user)
      {
        lat: user.latitude,
        lng: user.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { user: user, poster: poster }),
        image_url: helpers.asset_url('https://media.giphy.com/media/l44QvKoQuUD3xPZKg/giphy.gif')
      }
    end
  end

  private

  def latest_rental_poster(user)
    rental = user.rentals.last || Rental.all.last
    rental.title.imdb_poster["poster"]
  end
end
