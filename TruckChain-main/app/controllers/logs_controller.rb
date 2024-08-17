# frozen_string_literal: true

class LogsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    truck = Truck.find_by!(plate: log_params[:truck_plate])
    order = Order.find_by!(truck_id: truck.id, status: 0)

    coordinates = parse_gpgga log_params['gpgga']
    @log = Log.new({
                     temperature: log_params[:temperature],
                     order_id: order.id,
                     lat: coordinates[:latitude],
                     lng: coordinates[:longitude],
                     quantity: log_params[:quantity]
                   })

    if @log.save
      ActionCable.server.broadcast "log_#{@log.order.id}".to_sym, @log.to_json
      render json: @log, status: :created
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  private

  def parse_gpgga(gpgga_string)
    parts = gpgga_string.split(',')

    return nil unless parts[0] == '$GPGGA' && parts.length >= 10

    latitude = parts[2].to_f
    longitude = parts[4].to_f

    lat_degrees = latitude.floor / 100
    lat_minutes = latitude % 100
    latitude_decimal = lat_degrees + (lat_minutes / 60)

    long_degrees = longitude.floor / 100
    long_minutes = longitude % 100
    longitude_decimal = long_degrees + (long_minutes / 60)

    { latitude: latitude_decimal, longitude: longitude_decimal }
  end

  def log_params
    params.require(:log).permit(:temperature, :quantity, :gpgga, :truck_plate)
  end
end
