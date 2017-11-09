class PagesController < ApplicationController
  def home
    @accommodations = Accommodation.where(active: true).limit(3)
  end

  #STEP 1: we need check if the user provide information or not
  def search
    if params[:search].present? && params[:search].strip != ""
      # we use session variable here because we want to remember the location people search for
      #for the next search, they dont need to type it again
      session[:loc_search] = params[:search]
    end

  #STEP 2: if we have a value for the location, we gonna get all the room nearby the specific location (e.g. 5km)
    if session[:loc_search] && session[:loc_search] != ""
      @accommodations_address = Accommodation.where(active: true).near(session[:loc_search], 5, order: 'distance')
    else
      @accommodations_address = Accommodation.where(active: true).all
    end

  #STEP 3: once we got the result from STEP 2, we gonna apply all the filters,
  # we are passing the params of q to match the conditions of search.html.erb

    @search = @accommodations_address.ransack(params[:q])
    @accommodations = @search.result

    @arrAccommodations = @accommodations.to_a

  # STEP 4: if users search for the date range, for ever cases, we need to find any reservation of that room
  # within that time frame (i.e. if we found one of them, that means the accommodation is not available)
  # and we need to remove accommodation from our search

    if (params[:start_date] && params[:end_date] && !params[:start_date].empty? && !params[:end_date].empty?)
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])

      @accommodations.each do |accommodation|
        not_available = accommodation.reservations.where(
          "(? <= start_date AND start_date <= ?)
          OR (? <= end_date AND end_date <= ?)
          OR (start_date < ? AND ? < end_date)",
          start_date, end_date,
          start_date, end_date,
          start_date, end_date
        ).limit(1)


        if not_available.length > 0
          @arrAccommodations.delete(accommodation)
        end
      end
    end
  end
end
