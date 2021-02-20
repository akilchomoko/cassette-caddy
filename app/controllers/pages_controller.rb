class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :rick]
  
  def home
  end

  def rick
  end
end
