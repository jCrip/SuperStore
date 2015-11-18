class LocationsController < ApplicationController
  def get_address

    @user = current_user

    if @user
      @address = @user.address
      lat = @user.latitude
      lon = @user.longitude

      @markers = Gmaps4rails.build_markers(@user) do |user, marker|
        marker.lat lat
        marker.lng lon
        marker.title user.name
        marker.infowindow user.username
      end
    elsif
      lat = params[:latitude]
      lon = params[:longitude]
      @address = Geocoder.address("#{lat}, #{lon}")

      @markers = [{
        lat: lat,
        lng: lon
      }]
    end

    respond_to do |format|
      format.js
    end
  end
end
