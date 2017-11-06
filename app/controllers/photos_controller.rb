class PhotosController < ApplicationController

  def create
    @accommodation = Accommodation.find(params[:accommodation_id])

    if params[:images]
      params[:images].each do |img|
        @accommodation.photos.create(accommodation: img)
      end
    end

      @photos = @accommodation.photos
      redirect_back(fallback_location: request.referer, notice: "Saved...")
    end

  end
end
