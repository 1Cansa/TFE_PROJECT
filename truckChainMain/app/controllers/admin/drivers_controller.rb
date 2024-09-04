module Admin
  class DriversController < ApplicationController
    before_action :set_driver, only: %i[show edit update destroy]

    # GET /drivers
    def index
      @drivers = Driver.all
    end

    # GET /drivers/1
    def show; end

    # GET /drivers/new
    def new
      @driver = Driver.new
    end

    # GET /drivers/1/edit
    def edit; end

    # POST /drivers
    def create
      @driver = Driver.new(driver_params)

      if @driver.save
        redirect_to admin_driver_url(@driver), notice: "Driver was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /drivers/1
    def update
      if @driver.update(driver_params)
        redirect_to admin_driver_url(@driver), notice: "Driver was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /drivers/1
    def destroy
      @driver.destroy!
      redirect_to admin_drivers_url, notice: "Driver was successfully destroyed.", status: :see_other
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver
      @driver = Driver.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def driver_params
      params.require(:driver).permit(:name, :affiliation, :email, :phone_number)
    end
  end
end
