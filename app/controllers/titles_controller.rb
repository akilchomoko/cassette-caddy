class TitlesController < ApplicationController
    def index
        @title = Title.all
    end
end
