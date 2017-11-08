class PhotosController < ApplicationController

  def create
    @accommodation = Accommodation.find(params[:accommodation_id])

    if params[:images]
      params[:images].each do |img|
        @accommodation.photos.create(image: img)
      end

      @photos = @accommodation.photos
      redirect_back(fallback_location: request.referer, notice: "Saved...")
    end
  end

#delete photo upload
  def destroy
#this is going to find the photos that you want base on id
    @photo = Photo.find(params[:id])
    @accommodation = @photo.accommodation

#and then delete it
    @photo.destroy
#and then guess all of the remains of those belong to the id
    @photos = Photo.where(accommodation_id: @accommodation_id)

#returns to/render destroy.js.erb
    respond_to :js

  end
end
