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
    redirect_to @title
    # redirect_to root_url, alert: "Are you sure you want to rent this title?"
  end

  def create
    @rental = Rental.new(start_date: Date.today)
    @title = Title.find(params[:title_id])
    # @title.update(rent:true)
    # @title.save
    @rental.title = @title
    @rental.user = current_user
    @rental.save
    redirect_to title_path(@title)
  end

  def destroy
    @rental = Rental.find(params[:id])
    @rental.destroy
    redirect_to rental/[:title]
  end

  def edit
    @rental = Rental.find(params[:id])
    @rental.end_date = Date.today()
    @rental.save
    redirect_to user_path(current_user)
  end
end
