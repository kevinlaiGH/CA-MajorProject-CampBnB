class Accommodation < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :reservations

  has_many :guest_reviews

  geocoded_by :address
  after_validation :geocoder, if: :address_changed?

  validates :land_type, presence: true
  validates :accommodation_type, presence: true

  validates :area, presence: true
  validates :capacity, presence: true

##luke added geocoder for saving location to work##############################
  def geocoder
    puts "----im here"
  end
##

  def cover_photo(size)
    if self.photos.length > 0
      self.photos[0].image.url(size)
    else
      "blank.jpg"
    end
  end

  def average_rating
    # if guest reviews =0, it will just return to 0, otherwise(:) it will just
    # return to average that rounds up to 2 decimals
    guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
  end


end
