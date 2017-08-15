class Restaurant < ApplicationRecord
	belongs_to :user
	has_many :reservations, dependent: :destroy
    has_many :stars
    has_many :starred_by, through: :stars, source: :user
    has_and_belongs_to_many :categories

	validates :name, presence: true
    validates :street, presence: true
		validates :city, presence: true
		validates :state, presence: true
		validates :zip, presence: true
    validates :phone, presence: true

	def full_address
	 [self.street, self.city, self.state, self.zip].compact.join(', ')
	end

	geocoded_by :full_address
	after_validation :geocode

end
