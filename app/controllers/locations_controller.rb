class LocationsController < ApplicationController
  def get_address
    lat = params[:latitude]
    lon = params[:longitude]

    @address = Geocoder.address("#{lat}, #{lon}")

    respond_to do |format|
      format.js
    end
  end
end
