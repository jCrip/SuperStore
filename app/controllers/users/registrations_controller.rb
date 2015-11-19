class Users::RegistrationsController < Devise::RegistrationsController

  # GET /resource/edit
  def edit
    super

    @user = current_user
    lat = @user.latitude
    lon = @user.longitude

    @hash = Gmaps4rails.build_markers(@user) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.title user.name
      marker.infowindow user.username
    end

    if @hash.empty?
      @hash.push({
        lat: lat,
        lng: lon
        })
    end
  end

end
