class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
    @rental = Rental.new
  end

  def new
    @title = Title.find(params[:title_id])
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)
    @title = Title.find(params[:title_id])
    @rental.title = @rental
    @rental.save
    redirect_to rental/[:title_id]
  end

  def edit
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    @rental.update(params[:restaurant])
    redirect_to rental/[:title_id]
  end

  def destroy
    @rental = Rental.find(params[:id])
    @rental.destroy
    redirect_to rental/[:title]
  end
end

