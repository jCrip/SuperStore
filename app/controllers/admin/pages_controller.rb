class Admin::PagesController < ApplicationController
  load_and_authorize_resource
  before_action :require_admin

  def index
  end
end
