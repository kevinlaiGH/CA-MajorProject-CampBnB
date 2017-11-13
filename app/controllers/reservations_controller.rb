class ReservationsController < ApplicationController

  #only user that is login can make a booking
  before_action :authenticate_user!

  def create
    room = Accommodation.find(params[:accommodation_id])

    if current_user == accommodation.user
      flash[:alert] = "You cannot book your own property!"
    else
      start_date = Date.parse(reservation_params[:start_date])
      end_date = Date.parse(reservation_params[:end_date])

      days = (end_date - start_date).to_i + 1

      @reservation = current_user.reservations.build(reservation_params)
      @reservation.accommodation = accommodation
      @reservation.price = accommodation.price
      @reservation.total = accommodation.price * days
      @reservation.save

      flash[:notice] = "Booked Successfully!"
    end
    redirect_to accommodation
  end
end
