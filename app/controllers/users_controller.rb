class UsersController < ApplicationController
  def show
    @rentals = current_user.rentals
  end

  def edit
  end

  def update
  end
end
