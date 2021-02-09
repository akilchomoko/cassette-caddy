class TitlesController < ApplicationController
    skip_before_action :authenticate_user!, only: :index
    def index
        @title = Title.all
    end
end
