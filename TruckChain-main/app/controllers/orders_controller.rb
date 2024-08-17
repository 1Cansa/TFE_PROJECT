# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[show]
  before_action :authorize_user, only: %i[show]

  def show
    @log = Log.where(order_id: params[:id]).last
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def authorize_user
    return if current_user.id == @order.user.id

    render file: "#{Rails.root}/public/402.html", status: :forbidden
  end
end
