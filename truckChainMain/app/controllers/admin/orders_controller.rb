# frozen_string_literal: true

module Admin
  class OrdersController < ApplicationController
    before_action :set_order, only: %i[show edit update destroy stop]

    # GET /orders
    def index
      @orders = Order.all
    end

    # GET /orders/1
    def show
      @log = Log.where(order_id: params[:id]).last
    end

    def stop
      if @order.status.to_i.zero?
        begin
          @log = Log.where(order_id: params[:id]).last!
          @order.update(status: 2, received_quantity: @log.nil? ? 0 : @log.quantity)
          @order.truck.update(is_available: true)
          return redirect_to admin_order_url(@order), notice: 'Tracking terminé'
        rescue StandardError
          return redirect_to admin_order_url(@order), alert: 'Désolé aucune donnée reçue'
        end
      end

      redirect_to admin_order_url(@order), alert: "Désolé, impossible d'arrêter le tracking"
    end

    # GET /orders/new
    def new
      @order = Order.new
    end

    # GET /orders/1/edit
    def edit; end

    # POST /orders
    def create
      @order = Order.new(order_params)
      @order.status = 0

      if @order.save
        @order.truck.update(is_available: false)
        redirect_to admin_order_url(@order), notice: 'Order was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /orders/1
    def update
      if @order.update(order_params)
        redirect_to admin_order_url(@order), notice: 'Order was successfully updated.', status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /orders/1
    def destroy
      @order.destroy!
      redirect_to admin_orders_url, notice: 'Order was successfully destroyed.', status: :see_other
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(
        :status, :shipped_quantity, :received_quantity,
        :truck_id, :user_id, :shipped_at, :destination
      )
    end
  end
end
