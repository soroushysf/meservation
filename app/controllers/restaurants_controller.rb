class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy, :star]
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @dropdown_categories = Category.all

    if params[:cat_id].present?
      @categories = Category.find(params[:cat_id])
      @restaurants = @categories.restaurants
      @cat_name = Category.find(params[:cat_id]).name
      # @categories.each do |c|
      #   @restaurants << c.restaurants
      # end
    else
      @categories = Category.all
      @restaurants = Restaurant.all
      @cat_name = "All Categories"
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @reservation = Reservation.new
  end

  # GET /restaurants/new
  def new
    @restaurant = current_user.restaurants.build
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = current_user.restaurants.build(restaurant_params)
    current_user.update_attribute(:role, "owner") if current_user.patron?

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    current_user.update_attribute(:role, "patron") if current_user.restaurants.count == 0

    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Enable the user to star or unstar restaurants
  def star
    if !current_user.starred_restaurants.include?(@restaurant)
      current_user.starred_restaurants << @restaurant
    else
      current_user.starred_restaurants.delete(@restaurant)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def correct_user
      @restaurant = current_user.restaurants.find_by(id: params[:id])
      redirect_to restaurants_path, notice: "Not authorized to edit this restaurant" if @restaurant.nil? || !current_user.owner?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :street, :city, :state, :zip, :phone, :star, :category_ids => [])
    end
end
