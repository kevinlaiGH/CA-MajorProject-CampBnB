class Accommodation < ApplicationRecord
  belongs_to :user
  has_many :photos

  validates :land_type, presence: true
  validates :accommodation_type, presence: true

  validates :area, presence: true
  validates :capacity, presence: true
end