class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # TODO: add additional parameters to signup page
  # see https://kitt.lewagon.com/camps/476/lectures/05-Rails%2F06-Airbnb-Devise#/0/5/3
end
