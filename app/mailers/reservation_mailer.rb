class ReservationMailer < ApplicationMailer
	default from: "no-reply@restaurant-reservations.com"

	def reservation_notification(reservation)
	  @restaurant = reservation.restaurant
	  @restaurant_owner = @restaurant.user
	  mail(to: @restaurant_owner.email, subject: "A reservation was made for #{@restaurant.name}")
	end
end
