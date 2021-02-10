class UsersController < ApplicationController
  def show
    @rentals = current_user.rentals
  end
end
