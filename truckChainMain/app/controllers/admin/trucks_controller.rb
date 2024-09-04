# frozen_string_literal: true

module Admin
  class TrucksController < ApplicationController
    before_action :set_truck, only: %i[show edit update destroy]
    before_action :set_drivers, only: %i[new edit]

    # GET /trucks
    def index
      @trucks = Truck.all
    end

    # GET /trucks/1
    def show
      @orders = Order.where(truck_id: @truck.id)
    end

    # GET /trucks/new
    def new
      @truck = Truck.new
    end

    # GET /trucks/1/edit
    def edit; end

    # POST /trucks
    def create
      @truck = Truck.new(truck_params)

      if @truck.save
        redirect_to admin_truck_path(@truck), notice: 'Truck was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /trucks/1
    def update
      if @truck.update(truck_params)
        redirect_to admin_truck_path(@truck), notice: 'Truck was successfully updated.', status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /trucks/1
    def destroy
      @truck.destroy!
      redirect_to admin_trucks_url, notice: 'Truck was successfully destroyed.', status: :see_other
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_truck
      @truck = Truck.find(params[:id])
    end

    def set_drivers
      @drivers = Driver.all
    end

    # Only allow a list of trusted parameters through.
    def truck_params
      params.require(:truck).permit(:plate, :capacity, :is_available, :driver_id)
    end
  end
end
