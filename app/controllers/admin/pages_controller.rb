class Admin::PagesController < ApplicationController
  before_action :require_admin
  layout 'admin'
  def index

    @orders = Order.group(:status).count
    mappings = {0 => 'pendiente', 1 => 'pagado', 2 => 'cancelado'}

    @orders.keys.each { |k| @orders[ mappings[k] ] = @orders.delete(k) if mappings[k] }

    @paid_orders = Order.paid.group_by_day(:updated_at, format: '%d/%m/%y').count

  end
end
