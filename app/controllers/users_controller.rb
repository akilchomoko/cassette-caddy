class UsersController < ApplicationController
  def show
    @rentals = current_user.rentals.order(start_date: :desc)
  end

  def edit
  end

  def update
  end
end
