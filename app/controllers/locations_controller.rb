class LocationsController < ApplicationController
  def get_address

    @user = current_user

    if @user
      lat = @user.latitude
      lon = @user.longitude
      @address = @user.address
    end

    if
      lat = params[:latitude]
      lon = params[:longitude]
      @address = Geocoder.address("#{lat}, #{lon}")
    end

    @markers = [{
      lat: lat,
      lng: lon
    }]

    respond_to do |format|
      format.js
    end
  end
end
