class LocationsController < ApplicationController
    require 'json'
    require 'open-uri'
    
    def new
        @location = Location.new
    end
    
    def create
        @location = Location.create(location_params)
        redirect_to location_path(@location.id)
    end
    
    def show
        @location = Location.find(params[:id])
        @markers = find_museums(@location)


    end

    private

    def location_params
        params.require(:location).permit(:longitude, :latitude)
    end

    def find_museums(location)
        longitude = location.longitude
        latitude = location.latitude
        url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?proximity=#{longitude},#{latitude}&bbox=#{longitude - 0.1},#{latitude - 0.1},#{longitude + 0.1},#{latitude + 0.1}&access_token=pk.eyJ1IjoiYS1qZW5uaW5ncyIsImEiOiJja3RtcXBydDYwMWhlMm9uYm1lemEwNzZ1In0.ACkyNnU4NE8FNrVnDzWpyg"
        location_serialized = URI.open(url).read
        museum_locations = JSON.parse(location_serialized)      
        museum_locations['features'].map do |location|
            location['center']
        end
    end


end




