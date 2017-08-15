require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it 'validates the presence of name' do
    restaurant = Restaurant.new
    restaurant.valid?
    expect(restaurant.errors.messages[:name]).to include "can't be blank"
  end
end
