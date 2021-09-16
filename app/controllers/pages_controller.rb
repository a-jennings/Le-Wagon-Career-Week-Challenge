class PagesController < ApplicationController
    def home
        @location = Location.new
    end
end
