class LocationsController < ApplicationController

  def get_address
    @user = current_user

    if @user
      @products = Product.near(@user, 5)

      lat = @user.latitude
      lon = @user.longitude
      @address = @user.address

      @markers = Gmaps4rails.build_markers(@products) do |product, marker|
        marker.lat product.latitude
        marker.lng product.longitude
        marker.title product.name
        marker.infowindow product.address
      end

      @usermarker = {
        lat: lat,
        lng: lon,
        infowindow: @user.name,
        picture: {
          url: 'http://gmapsmarkergenerator.eu01.aws.af.cm/getmarker?scale=1&color=00ff00',
          width:  22,
          height: 40
        }
      }

    end

    if params[:latitude].present?

      lat = params[:latitude]
      lon = params[:longitude]
      @address = Geocoder.address("#{lat}, #{lon}")

      @usermarker = {
        lat: lat,
        lng: lon
      }

    end

    respond_to do |format|
      format.js
    end
  end

end
