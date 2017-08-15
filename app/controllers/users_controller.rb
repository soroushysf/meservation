class UsersController < ApplicationController
	before_action :authenticate_user!

	def dashboard
		@owner_restaurants = Restaurant.where(user_id: current_user.id)
	end

	def my_stars
		@my_stars = current_user.starred_restaurants
	end
end
