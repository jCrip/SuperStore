class Admin::PagesController < ApplicationController
  before_action :require_admin
  layout 'admin'
  def index
  end
end
