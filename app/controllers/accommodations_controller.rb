class AccommodationsController < ApplicationController

  #before you run any action below , just run set_accommodation first
before_action :set_accommodation, except: [:index, :new, :create]

  # we need user to login for updating listing/pricing/description
  # except show, you can view the accommodation without logging in, its public to everyone
before_action :authenticate_user!, except: [:show]

  def index
    # at index we want to list all the accommodations belong to the user,
    # so we create a new variable name accommodations
    #so .accommodations returns all the accommods onto this user
    @accommodations = current_user.accommodations
  end

  def new
    # when a user open a new page, it allows user to craete a new accommodation
    @accommodation = current_user.accommodations.build
  end

  def create
    # for create, we going to pass the accommods params
    @accommodation = current_user.accommodations(accommodation_params)
    if @accommodation.save
      redirect_to listing_accommodation_path(@accommodation), notice: "Saved..."
    else
      flash[:alert] = "Something went wrong..."
      render :new
    end
  end

  def listing
    # To be able to edit/update the listing, we need to know which
    # accommodation we are working on, first we have the accommod id as paramters.
    # we look inside the database, the accommod table to find the id and we return
    # to the variable. (DO the same for the other actions)
    set_accommodation
  end

  def show
  end

  def pricing
    set_accommodation
  end

  def description
    set_accommodation
  end

  def photo_upload
  end

  def amenities
  end

  def location
  end

  def update
    if @accommodation.update(accommodation_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Something went wrong..."
    end
      redirect_back(fallback_location: request.referer)
  end


    # To be able to edit/update the listing, we need to know which
    # accommodation we are working on, first we have the accommod id as paramters.
    # we look inside the database, the accommod table to find the id and we return
    # to the variable. (DO the same for the other actions)
  private
    def set_accommodation
      @accommodation = Accommodation.find(params[:id])
    end

    def accommodation_params
# whenever you want to crete/ update a room, you need to permit which attribute you
# allow users to update/edit/create
      params.require(:accommodation).permit(:land_type, :accommodation_type, :area, :capacity,
      :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet,
      :price, :active)
    end

end
