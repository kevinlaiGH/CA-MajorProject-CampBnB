class Accommodation < ApplicationRecord
  belongs_to :user
  has_many :photos

  geocoded_by :address
  after_validation :geocoder, if: :address_changed?

  validates :land_type, presence: true
  validates :accommodation_type, presence: true

  validates :area, presence: true
  validates :capacity, presence: true

  def cover_photo(size)
    if self.photos.length > 0
      self.photos[0].image.url(size)
    else
      "blank.jpg"
    end
  end


end
