class ReservationsController < ApplicationController
  before_action :set_restaurant
  before_action :set_reservation, only: [:destroy]
  # before_action :authenticate_user!, except: [:index]
  # before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    # @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = @restaurant.reservations.create(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @restaurant, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { redirect_to @restaurant, notice: 'Reservation not created.'  }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to @restaurant, notice: 'Reservation was deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
    # def correct_user
    #   @restaurant = current_user.restaurants.find_by(id: params[:id])
    #   redirect_to restaurants_path, notice: "Not authorized to edit this restaurant" if @restaurant.nil?
    # end

	def reservation_params
	  params.require(:reservation).permit(:email, :date, :time, :message)
	end
end
