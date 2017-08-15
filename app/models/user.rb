class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :restaurants, dependent: :destroy
  has_many :stars
  has_many :starred_restaurants, through: :stars, source: :restaurant
  
  validates :name, presence: true
  validates :email, presence: true

  def owner?
  	return true if self.role == 'owner'
    return false
  end
  
  def patron?
  	return true if self.role == 'patron'
    return false
  end

end
